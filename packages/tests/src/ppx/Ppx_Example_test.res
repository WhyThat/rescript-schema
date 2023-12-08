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
  deprecatedAgeRestriction: @s.matches(S.int->S.option->S.deprecate("Use rating instead"))
  option<int>,
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
type url = @s.matches(S.string->S.String.url) string
test("@s.matches", t => {
  t->assertEqualSchemas(urlSchema, S.string->S.String.url)
})

@schema
type stringWithDefault = @s.default("Unknown") string
test("@s.default", t => {
  t->assertEqualSchemas(stringWithDefaultSchema, S.option(S.string)->S.Option.getOr("Unknown"))
})
