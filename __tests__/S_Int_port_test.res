open Ava

test("Successfully parses valid data", t => {
  let struct = S.int()->S.Int.port()

  t->Assert.deepEqual(8080->S.parseWith(struct), Ok(8080), ())
})

test("Fails to parse invalid data", t => {
  let struct = S.int()->S.Int.port()

  t->Assert.deepEqual(
    65536->S.parseWith(struct),
    Error({
      code: OperationFailed("Invalid port"),
      operation: Parsing,
      path: [],
    }),
    (),
  )
})

test("Successfully serializes valid value", t => {
  let struct = S.int()->S.Int.port()

  t->Assert.deepEqual(8080->S.serializeWith(struct), Ok(%raw(`8080`)), ())
})

test("Fails to serialize invalid value", t => {
  let struct = S.int()->S.Int.port()

  t->Assert.deepEqual(
    -80->S.serializeWith(struct),
    Error({
      code: OperationFailed("Invalid port"),
      operation: Serializing,
      path: [],
    }),
    (),
  )
})

test("Returns custom error message", t => {
  let struct = S.string()->S.String.uuid(~message="Custom", ())

  t->Assert.deepEqual(
    "4000"->S.parseWith(struct),
    Error({
      code: OperationFailed("Custom"),
      operation: Parsing,
      path: [],
    }),
    (),
  )
})
