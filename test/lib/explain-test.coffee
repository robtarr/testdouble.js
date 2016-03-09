describe '.explain', ->
  Given -> @testDouble = td.function()
  When -> @result = td.explain(@testDouble)

  context 'a brand new test double', ->
    Then -> expect(@result).to.deep.eq
      calls: []
      callCount: 0
      description: """
      This test double has 0 stubbings and 0 invocations.
      """

  context 'a named test double', ->
    Given -> @testDouble = td.function("foobaby")
    Then -> expect(@result.description).to.deep.eq """
      This test double `foobaby` has 0 stubbings and 0 invocations.
      """

  context 'a double with some interactions', ->
    Given -> td.when(@testDouble(88)).thenReturn(5)
    Given -> td.when(@testDouble("two things!")).thenReturn("woah", "such")
    Given -> @testDouble(88)
    Given -> @testDouble("not 88", 44)

    Then -> expect(@result).to.deep.eq
      calls: [
        {context: this, args: [88]},
        {context: this, args: ["not 88", 44]}
      ]
      callCount: 2
      description: """
      This test double has 2 stubbings and 2 invocations.

      Stubbings:
        - when called with `(88)`, then return `5`.
        - when called with `("two things!")`, then return `"woah"`, then `"such"`.

      Invocations:
        - called with `(88)`.
        - called with `("not 88", 44)`.
      """
