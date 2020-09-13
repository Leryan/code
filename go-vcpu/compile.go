package vcpu

import (
	"fmt"
	"strconv"
	"strings"
)

// OPMap opname and opfunc
type OPMap map[string]func(*OPStack, interface{}, interface{})

// DefaultOPMap returns the defaut operand mapping
func DefaultOPMap() OPMap {
	opmap := make(OPMap)
	opmap["load"] = OPLoad
	opmap["eq"] = OPEquals
	opmap["neq"] = OPNEquals
	opmap["move"] = OPMvVal
	opmap["noop"] = OPNOOP
	opmap["or"] = OPOr
	opmap["and"] = OPAnd
	opmap["print"] = OPPrint
	opmap["jump"] = OPJump
	return opmap
}

// Compile source file to an OPStack
func Compile(opmap OPMap, src string) (OPStack, error) {
	os := NewOPStack()
	instructions := strings.Split(src, "\n")
	addrcount := uint64(0)
	for i := 0; i < len(instructions); i++ {
		inst := instructions[i]

		if inst == "" {
			continue
		}

		s := strings.SplitN(inst, " ", 3)
		opname := "#"
		oplval := ""
		oprval := ""
		if len(s) > 2 {
			oprval = s[2]
		}
		if len(s) > 1 {
			oplval = s[1]
		}
		if len(s) > 0 && s[0] != "" {
			opname = s[0]
		} else {
			return os, fmt.Errorf("bad instruction: %s", inst)
		}

		if opname[0] == '#' {
			continue
		}

		if opname[0] == '.' {
			os.lbladdr[opname] = addrcount - 1
		} else {
			callable := opmap[opname]
			if callable == nil {
				return os, fmt.Errorf("unsupported instruction: %s", inst)
			}
			if opname == "move" {
				var foplval interface{}
				var err error
				valtype := oprval
				switch valtype {
				case "float32":
					foplval, err = strconv.ParseFloat(oplval, 32)
				case "float64":
					foplval, err = strconv.ParseFloat(oplval, 64)
				case "int8":
					foplval, err = strconv.ParseInt(oplval, 10, 8)
				case "uint8":
					foplval, err = strconv.ParseUint(oplval, 10, 8)
				case "int16":
					foplval, err = strconv.ParseInt(oplval, 10, 16)
				case "uint16":
					foplval, err = strconv.ParseUint(oplval, 10, 16)
				case "int":
					foplval, err = strconv.ParseInt(oplval, 10, 32)
				case "uint":
					foplval, err = strconv.ParseUint(oplval, 10, 32)
				case "int32":
					foplval, err = strconv.ParseInt(oplval, 10, 32)
				case "uint32":
					foplval, err = strconv.ParseUint(oplval, 10, 32)
				case "int64":
					foplval, err = strconv.ParseInt(oplval, 10, 64)
				case "uint64":
					foplval, err = strconv.ParseUint(oplval, 10, 64)
				default:
					foplval = oplval
				}
				if err != nil {
					return os, err
				}
				os.Add(OP{
					Callable:    callable,
					LVal:        foplval,
					RVal:        oprval,
					Instruction: inst,
				})
			} else {
				os.Add(OP{
					Callable:    callable,
					LVal:        oplval,
					RVal:        oprval,
					Instruction: inst,
				})
			}
			addrcount++
		}
	}
	return os, nil
}
