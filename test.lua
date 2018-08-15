local sw_variable = require [[seawolf.variable]]
local print_r = sw_variable.print_r

local l10n = require [[l10n]]
local t = l10n.translate

l10n.set_lang [[spa]]
l10n.add {[[Hello %s!]], spa = [[¡Hola %s!]]}
l10n.add {[[world]], spa = [[mundo]]}

assert(t([[Hello %s!]], t [[world]]) == [[¡Hola mundo!]])

-- Throw a warning on unknown string
local unknown_string = [[Would you translate this for me?]]
assert(t(unknown_string) == unknown_string)

-- Throw a warning when translation not available
l10n.set_lang [[fre]]
local missing_translation = [[Do you speak French?]]
l10n.add {missing_translation, spa = [[¿Hablas francés?]]}
assert(t(missing_translation) == missing_translation)

print_r(l10n.db)