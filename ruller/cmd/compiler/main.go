package main

import (
	"encoding/json"
	"eventfilter/pkg/compiler"
	"flag"
	"io/ioutil"
	"log"
	"os"
)

func checkFile(path string, msg string) {
	_, err := os.Stat(path)
	if err != nil {
		log.Fatalf("%s: %v", msg, err)
	}
}

func main() {
	flagRuleFile := flag.String("rulesfile", "rules.json", "Path to JSON with rules. Must be an array of map.")
	flagOutput := flag.String("output", "rules.go", "Path to Go code output.")
	flag.Parse()

	checkFile(*flagRuleFile, "rules")

	ruleFile, err := os.OpenFile(*flagRuleFile, os.O_RDONLY, 0640)
	if err != nil {
		log.Fatalf("open rules: %v", err)
	}

	ruleString, err := ioutil.ReadAll(ruleFile)
	if err != nil {
		log.Fatalf("read rules: %v", err)
	}

	var rules []map[string]interface{}
	err = json.Unmarshal(ruleString, &rules)

	if err != nil {
		log.Fatalf("unmarshal rules: %v", err)
	}

	c := compiler.NewCompiler(rules)

	result, err := c.Compile(true)
	if err != nil {
		log.Printf("compile error: %v", err)
	}

	log.Printf("output: %s", *flagOutput)
	os.Remove(*flagOutput)
	fh, err := os.OpenFile(*flagOutput, os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatalf("error: %v", err)
	}
	fh.WriteString(result)
	fh.Close()
}
