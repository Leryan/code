package main

import (
	"encoding/json"
	"eventfilter/pkg/types"
	"flag"
	"io/ioutil"
	"log"
	"os"
	"plugin"
)

func main() {
	flagPluginFile := flag.String("rules", "rules.so", "Path to binary plugin file.")
	flagInputsFile := flag.String("inputs", "inputs.json", "Path to JSON inputs.")
	flag.Parse()

	inputsFile, err := os.OpenFile(*flagInputsFile, os.O_RDONLY, 0640)
	if err != nil {
		log.Fatalf("inputs open: %v", err)
	}

	inputsBytes, err := ioutil.ReadAll(inputsFile)
	var inputs []map[string]interface{}
	if err = json.Unmarshal(inputsBytes, &inputs); err != nil {
		log.Fatalf("inputs unmarshal: %v", err)
	}

	plug, err := plugin.Open(*flagPluginFile)
	if err != nil {
		log.Fatalf("plugin open: %v", err)
	}

	collectSym, err := plug.Lookup("CollectFilters")
	if err != nil {
		log.Fatalf("plugin CollectFilters symbol: %v", err)
	}

	prepareSym, err := plug.Lookup("Prepare")
	if err != nil {
		log.Fatalf("plugin CollectFilters symbol: %v", err)
	}

	collectFunc := collectSym.(func(*[]types.Filter) error)
	prepareFunc := prepareSym.(func() error)

	filters := make([]types.Filter, 0)

	if err = prepareFunc(); err != nil {
		log.Fatalf("prepare failure: %v", err)
	}
	collectFunc(&filters)

	log.Printf("loaded %d filters", len(filters))
	log.Printf("loaded %d inputs", len(inputs))

	for j, input := range inputs {
		for i, filter := range filters {
			filter.SetInput(input)
			if filter.Check() {
				log.Printf("filter %d matched input %d", i, j)
			} else {
				log.Printf("filter %d did NOT match input %d", i, j)
			}
		}
	}
}
