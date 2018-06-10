#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function, unicode_literals

import argparse

from sqlalchemy.exc import SQLAlchemyError as SQLError
from sqlalchemy.sql import text as SQLQuery
from sqlalchemy import create_engine as SQLEngine

class CentreonCmd(object):
    def __init__(self, uri, *args, **kwargs):
        super(CentreonCmd, self).__init__(*args, **kwargs)

        self._uri = uri

    def connect(self):
        self.engine = SQLEngine(self._uri)
        self.conn = self.engine.connect()

    def query(self, query, params):
        q = SQLQuery(query)

        res = self.conn.execute(q, **params)

        keys = res.keys()
        rows = res.fetchall()
        items = []

        for row in rows:
            items.append(dict(zip(keys, row)))

        return items

    def get_host_id(self, host):
        query = """select host_id
        from host
        where host_name like :host"""
        params = {'host': host}

        res = self.query(query, params)

        if len(res) == 1:
            return int(res[0]['host_id'])

        raise Exception('No such host')

    def get_svc_id(self, hostid, service):
        query = """select *
        from service as s, host_service_relation as hsr
        where s.service_description like :svcdesc
        and hsr.host_host_id = :hostid
        and hsr.service_service_id = s.service_id"""

        params = {'svcdesc': service, 'hostid': hostid}

        res = self.query(query, params)
        
        if len(res) == 1:
            return int(res[0]['service_id'])

        raise Exception('No such service')

    def get_svc_templateid(self, serviceid):
        query = """select s.service_template_model_stm_id
        from service as s
        where s.service_id = :service_id
        and s.service_template_model_stm_id is not null"""
        params = {'service_id': serviceid}

        res = self.query(query, params)

        if len(res) == 1:
            return int(res[0]['service_template_model_stm_id'])

        raise Exception('No template for this service')

    def get_svc_cmdid(self, serviceid):
        query = """select s.command_command_id
        from service as s
        where s.command_command_id is not null
        and s.service_id = :serviceid"""
        params = {'serviceid': serviceid}

        res = self.query(query, params)

        if len(res) == 1:
            return int(res[0]['command_command_id'])
        else:
            try:
                svc_tmpl_id = self.get_svc_templateid(serviceid)
                return self.get_svc_cmdid(svc_tmpl_id)
            except Exception:
                return None

    def get_cmd_args(self, serviceid):
        query = """select s.command_command_id_arg
        from service as s
        where s.service_id = :serviceid
        and s.command_command_id_arg is not null"""
        params = {'serviceid': serviceid}

        res = self.query(query, params)

        if len(res) == 1:
            argstxt = res[0]['command_command_id_arg'][1:]
            args = argstxt.split('!')
            return args
        else:
            try:
                svc_tmpl_id = self.get_svc_templateid(serviceid)
                return self.get_cmd_args(svc_tmpl_id)
            except Exception:
                return []

    def get_cmd_text(self, cmdid):
        query = """select * from command
        where command_id = :cmdid"""
        params = {'cmdid': cmdid}

        res = self.query(query, params)

        if len(res) == 1:
            return res[0]['command_line']
        else:
            raise Exception('No such command')

    def get_svc_macros(self, serviceid, macros={}):
        query = """select svc_macro_name, svc_macro_value
        from on_demand_macro_service
        where svc_svc_id = :serviceid"""
        params = {'serviceid': serviceid}

        res = self.query(query, params)

        for r in res:
            if r['svc_macro_name'] not in macros.keys():
                macros[r['svc_macro_name']] = r['svc_macro_value']

        try:
            svc_tmpl_id = self.get_svc_templateid(serviceid)
            macros = self.get_svc_macros(svc_tmpl_id, macros)
        except Exception:
            pass

        return macros

    def get_host_templateids(self, hostid):
        query = """select host_tpl_id
        from host_template_relation
        where host_host_id = :hostid
        order by `order`"""
        params = {'hostid': hostid}

        res = self.query(query, params)

        ids = []

        for r in res:
            ids.append(int(r['host_tpl_id']))

        return ids

    def get_host_macros(self, hostid, macros={}):
        query = """select host_macro_name, host_macro_value
        from on_demand_macro_host
        where host_host_id = :hostid"""
        params = {'hostid': hostid}

        res = self.query(query, params)

        for r in res:
            if r['host_macro_name'] not in macros.keys():
                macros[r['host_macro_name']] = r['host_macro_value']

        try:
            host_tmpl_ids = self.get_host_templateids(hostid)
            for host_tmpl_id in host_tmpl_ids:
                macros = self.get_host_macros(host_tmpl_id, macros)
        except Exception:
            pass

        return macros

    def get_host_info(self, hostid, info, default=None):
        query = """select * from host
        where host_id = :hostid"""
        params = {'hostid': hostid}

        res = self.query(query, params)

        if len(res) == 1:
            return res[0][info]
        else:
            try:
                host_tmpl_ids = self.get_host_templateids(hostid)
                for host_tmpl_id in host_tmpl_ids:
                    val = self.get_host_info(host_tmpl_id, info, default)
                    if val is not None:
                        return val
            except Exception:
                pass

        return default

    def get_poller_resources(self, pollerid):
        query = """select *
        from cfg_resource as r, cfg_resource_instance_relations rir
        where rir.instance_id = :pollerid
        and rir.resource_id = r.resource_id
        and r.resource_activate = '1'"""
        params = {'pollerid': pollerid}

        res = self.query(query, params)

        return res

    def replace_args(self, cmdtxt, cmdargs):
        for i, cmdarg in enumerate(cmdargs):
            argname = '$ARG{0}$'.format(i + 1)
            argvalue = cmdarg

            cmdtxt = cmdtxt.replace(argname, argvalue)

        return cmdtxt

    def replace_svc_macros(self, cmdtxt, svcmacros):
        for mkey, mval in svcmacros.iteritems():
            cmdtxt = cmdtxt.replace(mkey, mval)

        return cmdtxt

    def replace_host_macros(self, cmdtxt, hostmacros):
        for mkey, mval in hostmacros.iteritems():
            cmdtxt = cmdtxt.replace(mkey, mval)

        return cmdtxt

    def replace_nagios_macro(self, cmdtxt, with_func, infoname, objectid, nmacro, default = ''):
        macro_value = with_func(objectid, infoname, default)

        if macro_value is None:
            return cmdtxt.replace(nmacro, default)

        return cmdtxt.replace(nmacro, macro_value)

    def get_poller_infos(self, pollerid):
        query = """select * from nagios_server
        where id = :pollerid"""
        params = {'pollerid': pollerid}

        return self.query(query, params)[0]

    def get_host_poller(self, hostid):
        query = """select nagios_server_id
        from ns_host_relation
        where host_host_id = :hostid"""
        params = {'hostid': hostid}

        pollerid = self.query(query, params)[0]['nagios_server_id']

        return pollerid

    def replace_resources(self, cmdtxt, resources):
        for res in resources:
            cmdtxt = cmdtxt.replace(res['resource_name'], res['resource_line'])

        return cmdtxt

    def get_fullcmd(self, pollerid, hostid, serviceid):
        cmdid = self.get_svc_cmdid(serviceid)
        cmdargs = self.get_cmd_args(serviceid)
        cmdtxt = self.get_cmd_text(cmdid)
        svcmacros = self.get_svc_macros(serviceid)
        hostmacros = self.get_host_macros(hostid)
        resources = self.get_poller_resources(pollerid)

        cmdtxt = self.replace_resources(cmdtxt, resources)
        cmdtxt = self.replace_args(cmdtxt, cmdargs)
        cmdtxt = self.replace_svc_macros(cmdtxt, svcmacros)
        cmdtxt = self.replace_host_macros(cmdtxt, hostmacros)

        cmdtxt = self.replace_nagios_macro(cmdtxt, self.get_host_info, 'host_address', hostid, '$HOSTADDRESS$')
        cmdtxt = self.replace_nagios_macro(cmdtxt, self.get_host_info, 'host_snmp_community', hostid, '$_HOSTSNMPCOMMUNITY$')
        cmdtxt = self.replace_nagios_macro(cmdtxt, self.get_host_info, 'host_snmp_version', hostid, '$_HOSTSNMPVERSION$')

        return cmdtxt

    def get_fullinfos(self, host, service):
        hostid = self.get_host_id(host)
        pollerid = self.get_host_poller(hostid)
        serviceid = self.get_svc_id(hostid, service)

        cmdtxt = self.get_fullcmd(pollerid, hostid, serviceid)
        poller = self.get_poller_infos(pollerid)

        return {'poller': poller, 'cmd': cmdtxt}

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dburi', type=str,
        default='mysql://centreon:centreon@localhost:3306/centreon',
        help='database uri. example: mysql://centuser:centpass@localhost:3306/centreondb')
    parser.add_argument('--host', type=str, required=True, help='centreon host name')
    parser.add_argument('--service', type=str, required=True, help='centreon service of --host')

    args = parser.parse_args()

    cc = CentreonCmd(args.dburi)
    cc.connect()
    infos = cc.get_fullinfos(args.host, args.service)

    print(' + run: {0}'.format(infos['cmd']))
    print(' + on poller: {0}'.format(infos['poller']['name']))


if __name__ == '__main__':
    main()
