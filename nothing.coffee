## BOOLEANS ##
TRUE  = (x) -> (y) -> x
FALSE = (x) -> (y) -> y

## CONTROL STRUCTURES ##
#IF = (b) -> (x) -> (y) -> b(x)(y)
#IF = (b) -> (x) -> b(x)
IF = (b) -> b

## MATH ##
ZED              = (f) -> ((x) -> f((y) -> x(x)(y)))((x) -> f((y) -> x(x)(y)))
INCREMENT        = (n) -> (p) -> (x) -> p(n(p)(x))
DECREMENT        = (n) -> (f) -> (x) -> n((g) -> (h) -> h(g(f)))((y) -> x)((y) -> y)
ADD              = (m) -> (n) -> n(INCREMENT)(m)
SUBTRACT         = (m) -> (n) -> n(DECREMENT)(m)
MULTIPLY         = (m) -> (n) -> n(ADD(m))(ZERO)
DIV              = ZED((f) -> (m) -> (n) -> IF(IS_LESS_OR_EQUAL(n)(m))((x) -> INCREMENT(f(SUBTRACT(m)(n))(n))(x))(ZERO))
POWER            = (m) -> (n) -> n(MULTIPLY(m))(ONE)
IS_ZERO          = (n) -> n((x) -> FALSE)(TRUE)
IS_LESS_OR_EQUAL = (m) -> (n) -> IS_ZERO(SUBTRACT(m)(n))
MOD              = ZED((f) -> (m) -> (n) -> IF(IS_LESS_OR_EQUAL(n)(m))((x) -> f(SUBTRACT(m)(n))(n)(x))(m))

## NUMBERS ##
ZERO    = (p) -> (x) -> x
ONE     = (p) -> (x) -> p(x)
TWO     = INCREMENT(ONE)
THREE   = INCREMENT(TWO)
FOUR    = MULTIPLY(TWO)(TWO)
FIVE    = INCREMENT(FOUR)
SIX     = MULTIPLY(TWO)(THREE)
SEVEN   = INCREMENT(SIX)
EIGHT   = POWER(TWO)(TWO)
NINE    = POWER(THREE)(TWO)
TEN     = MULTIPLY(TWO)(FIVE)
FIFTEEN = MULTIPLY(THREE)(FIVE)
HUNDRED = POWER(TEN)(TWO)

## LISTS ##
PAIR     = (x) -> (y) -> (f) -> f(x)(y)
LEFT     = (p) -> p((x) -> (y) -> (x))
RIGHT    = (p) -> p((x) -> (y) -> (y))
EMPTY    = PAIR(TRUE)(TRUE)
UNSHIFT  = (l) -> (x) -> PAIR(FALSE)(PAIR(x)(l))
IS_EMPTY = LEFT
FIRST    = (l) -> LEFT(RIGHT(l))
REST     = (l) -> RIGHT(RIGHT(l))
RANGE    = ZED((f) -> (m) -> (n) -> IF(IS_LESS_OR_EQUAL(m)(n))((x) -> UNSHIFT(f(INCREMENT(m))(n))(m)(x))(EMPTY))
FOLD     = ZED((f) -> (l) -> (x) -> (g) -> IF(IS_EMPTY(l))(x)((y) -> g(f(REST(l))(x)(g))(FIRST(l))(y)))
MAP      = (k) -> (f) -> FOLD(k)(EMPTY)((l) -> (x) -> UNSHIFT(l)(f(x)))
PUSH     = (l) -> (x) -> FOLD(l)(UNSHIFT(EMPTY)(x))(UNSHIFT)

## LETTERS ##
B = TEN
F = INCREMENT(B)
I = INCREMENT(F)
U = INCREMENT(I)
Z = INCREMENT(U)

## WORDS ##
FIZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(Z))(Z))(I))(F)
BUZZ     = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(EMPTY)(Z))(Z))(U))(B)
FIZZBUZZ = UNSHIFT(UNSHIFT(UNSHIFT(UNSHIFT(BUZZ)(Z))(Z))(I))(F)

## CONVERTERS ##
TO_DIGITS = ZED((f) -> (n) -> PUSH(IF(IS_LESS_OR_EQUAL(n)(DECREMENT(TEN)))(EMPTY)((x) -> f(DIV(n)(TEN))(x)))(MOD(n)(TEN)))

## COFFEESCRIPT CONVERTERS ##
to_integer = (n) -> n((x) -> x+1)(0)
to_boolean = (p) -> IF(p)(true)(false)
to_char    = (c) -> '0123456789BFiuz'[to_integer(c)]
to_string  = (s) -> to_array(s).map((c) -> to_char c).join ''
to_array   = (p) -> 
  array = []
  until to_boolean(IS_EMPTY(p))
    array.push(FIRST(p))
    p = REST(p)
  array

## COFFEESCRIPT IMPLEMENTATION OF FIZZBUZZ ##
fb1 = [1..100].map (n) ->
  return 'FizzBuzz' if n % 15 == 0
  return 'Fizz'     if n %  3 == 0
  return 'Buzz'     if n %  5 == 0
  return "#{n}"

## PROC IMPLEMENTATION OF FIZZBUZZ ##
fb2_fns = MAP(RANGE(ONE)(HUNDRED))((n) -> 
  IF(IS_ZERO(MOD(n)(FIFTEEN)))(FIZZBUZZ)(IF(IS_ZERO(MOD(n)(THREE)))(FIZZ)(IF(IS_ZERO(MOD(n)(FIVE)))(BUZZ)(TO_DIGITS(n)))))

fb2 = to_array(fb2_fns).map (n) -> to_string(n)

## TEST ##
array_equal = (a, b) ->
  return false unless a[i] == b[i] for i in a
  true

console.log(fb2.join(', '))
console.log("Equal?", array_equal(fb1, fb2))
