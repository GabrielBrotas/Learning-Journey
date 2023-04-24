Avro is defined by a schema (schema is written in JSON)

Advantages:

- Data is fully typed
- Data is compressed automatically(less CPU usage)
- Schema (defined using JSON) comes along with the data
- Documentation is embedded in the schema

Primitive types:

- null: no value
- boolean: binary value
- int: 32-bit signed integer
- long: 64-bit signed integer
- float: single precision(32-bit) IEEE 754 floating-point number
- double: double precision (64-bit) IEEE 754 floating point number
- bytes: sequence of 8-bit unsigned bytes
- string: unicode character sequence

### Avro Record Schemas

Avro Record Schemas are defined using JSON

it has some common fields:

- Name: name of your schema
- Namespace: "package”
- Doc: documentation to explain your schema
- Aliases: Optional other names for your schema
- Fields
    - Name: field name
    - Doc: field doc
    - Type: field value
    - Default: default value

ex:

```json
{
	"type": "record",
	"namespace": "com.example",
	"name": "Customer",
	"doc": "Avro schema for our customer",
	"fields": [
		{"name": "first_name", "type": "string", "doc": ""},
	]
}
```

Others types:

- Enums

```json
{"type": "enum", "name": "CustomerStatus", "symbols": ["BRONZE", "SILVER", "GOLD"]}
```

- Array

```json
{"type": "array", "items": ["string"]}
```

- Maps: Key values

```json
{"type": "map", "values": "string"}
```

- Unions: allow a field value to take different types

```json
{"name": "middle_name", "type": ["null", "string"], "default": null}
```