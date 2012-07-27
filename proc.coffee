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
