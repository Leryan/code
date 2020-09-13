package functions

func getFieldValue(input map[string]interface{}, field string) (interface{}, bool) {
	value, exists := input[field]
	return value, exists
}

func Equal(input map[string]interface{}, values map[string]interface{}, field string, valueID string) bool {
	value, exists := getFieldValue(input, field)

	if exists {
		return value == values[valueID]
	}

	return false
}
