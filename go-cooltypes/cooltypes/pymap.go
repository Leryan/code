package cooltypes

// PyMap is like a python dict()
type PyMap map[interface{}]interface{}

// GetDef returns the value stored at key, or def if not found
func (m PyMap) GetDef(key interface{}, def interface{}) interface{} {
	val, exists := m[key]

	if !exists {
		return def
	}

	return val
}

// Get returns nil if key is not found in the map
func (m PyMap) Get(key interface{}) interface{} {
	val, exists := m[key]

	if !exists {
		return nil
	}

	return val
}

// Del is a shortcut for delete()
func (m PyMap) Del(key interface{}) {
	delete(m, key)
}

// Set is a shortcut for m[key] = val
func (m PyMap) Set(key interface{}, val interface{}) {
	m[key] = val
}

// NewPyMap creates a new PyMap
func NewPyMap() PyMap {
	return make(PyMap)
}
