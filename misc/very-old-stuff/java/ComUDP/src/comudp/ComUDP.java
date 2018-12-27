/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package comudp;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;

public class ComUDP {

    DatagramSocket socket;
    String messageRecu = "";
    String messageEnvoye = "";
    InetAddress adresseServeur;
    int portServeur;

    public ComUDP(String host) throws SocketException, UnknownHostException {
        this.adresseServeur = InetAddress.getByName(host.split(":")[0]);
        this.portServeur = Integer.valueOf(host.split(":")[1]);
        this.socket = new DatagramSocket(this.portServeur);
    }

    public String EnvoyerUDP(String cmd, int timeout) {
    	Thread t;
        t = this.Envoyer(cmd, timeout);
        while(t.isAlive());
        return this.messageRecu;
    }

    public Thread Recevoir(final int timeout) {
        Thread MonthId = new Thread(new Runnable() {

            @Override
            public void run() {
                byte buff[] = new byte[128];
                try {
                    DatagramPacket datag = new DatagramPacket(buff, buff.length);
                    socket.setSoTimeout(timeout);
                    socket.receive(datag);
                    socket.send(datag);
                    messageRecu = new String(datag.getData());
                } catch (Exception e) {
                    messageRecu = "Client lost.";
                }
            }
        });
        MonthId.start();
        return MonthId;
    }

    public Thread Envoyer(String message, final int timeout) {
        messageEnvoye = message;
        Thread MonthId = new Thread(new Runnable() {

            @Override
            public void run() {
                byte buff[] = messageEnvoye.getBytes();
                try {
                    DatagramPacket datag = new DatagramPacket(buff, buff.length, adresseServeur, portServeur);
                    socket.setSoTimeout(timeout);
                    socket.send(datag);
                    socket.receive(datag);
                    messageRecu = new String(datag.getData());

                } catch (Exception e) {
                    messageRecu = "No answer.";
                }
            }
        });
        MonthId.start();
        return MonthId;
    }
}
