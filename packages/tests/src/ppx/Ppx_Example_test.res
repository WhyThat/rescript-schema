open Ava
open U

@schema
type rating =
  | @as("G") GeneralAudiences
  | @as("PG") ParentalGuidanceSuggested
  | @as("PG13") ParentalStronglyCautioned
  | @as("R") Restricted
@schema
type film = {
  @as("Id")
  id: float,
  @as("Title")
  title: string,
  @as("Tags")
  tags: @s.default([]) array<string>,
  @as("Rating")
  rating: rating,
  @as("Age")
  deprecatedAgeRestriction: @s.deprecated("Use rating instead") option<int>,
}

test("Main example", t => {
  t->assertEqualSchemas(
    filmSchema,
    S.object(s => {
      id: s.field("Id", S.float),
      title: s.field("Title", S.string),
      tags: s.fieldOr("Tags", S.array(S.string), []),
      rating: s.field(
        "Rating",
        S.union([
          S.literal(GeneralAudiences),
          S.literal(ParentalGuidanceSuggested),
          S.literal(ParentalStronglyCautioned),
          S.literal(Restricted),
        ]),
      ),
      deprecatedAgeRestriction: s.field("Age", S.option(S.int)->S.deprecate("Use rating instead")),
    }),
  )
})

@schema
type matches = @s.matches(S.string->S.String.url) string
test("@s.matches", t => {
  t->assertEqualSchemas(matchesSchema, S.string->S.String.url)
})

@schema
type default = @s.default("Unknown") string
test("@s.default", t => {
  t->assertEqualSchemas(defaultSchema, S.option(S.string)->S.Option.getOr("Unknown"))
})

@schema
type defaultWith = @s.defaultWith(() => []) array<string>
test("@s.defaultWith", t => {
  t->assertEqualSchemas(
    defaultWithSchema,
    S.option(S.array(S.string))->S.Option.getOrWith(() => []),
  )
})

@schema
type null = @s.null option<string>
test("@s.null", t => {
  t->assertEqualSchemas(nullSchema, S.null(S.string))
})

@schema
type nullWithDefault = @s.null @s.default("Unknown") string
test("@s.null with @s.default", t => {
  t->assertEqualSchemas(nullWithDefaultSchema, S.null(S.string)->S.Option.getOr("Unknown"))
})

@schema
type deprecated = @s.deprecated("Will be removed in APIv2") string
test("@s.deprecated", t => {
  t->assertEqualSchemas(deprecatedSchema, S.string->S.deprecate("Will be removed in APIv2"))
})
