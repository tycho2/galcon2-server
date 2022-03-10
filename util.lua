function util_firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end