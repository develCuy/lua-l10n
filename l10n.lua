-----------------------------------------------------------------------------
-- Localization (l10n) for the Lua language.
-- Author: Fernando Paredes Garcia (fernando@develcuy.com)
-----------------------------------------------------------------------------

-- Storage for all available translations on runtime
local db = {}

local target_lang -- language to translate to

local function set_lang(lang)
  target_lang = lang
end

local function translate(str, ...)
  if nil == target_lang then
    error [[l10n: target language not set. Example: l10n.set_lang 'es']]
  end
  if [[string]] ~= type(str) then
    error [[l10n: Not a valid string provided!]]
  end
  if nil == db[str] then
    return
  end
  local target = db[str][target_lang] or str
  if target then
    local params = {...}
    return
      nil ~= next(params) and
      target:format(...) or
      target
  end
end

local function add(params)
  if
    [[table]] == type(params) and
    [[string]] == type(params[1])
  then
    local source = params[1]
    params[1] = nil
    for lang, target in pairs(params) do
      db[source] = {[lang] = target}
    end
  else
    error [[l10n: Invalid input!]]
  end
end

return {
  add = add,
  db = db,
  set_lang = set_lang,
  translate = translate,
}
