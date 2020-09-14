package types

type Filter interface {
	SetInput(input map[string]interface{})
	Check() bool
}
