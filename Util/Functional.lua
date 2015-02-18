function get(member)
    return function(tbl)
        return tbl[member]
    end
end

function fn(method)
    return function(tbl)
        return tbl[method]()
    end
end

function curry(func, arg)
    return function(...)
        return func(arg, ...)
    end
end

function head(tbl)
    return tbl[1]
end

function tail(tbl)
    if table.getn(tbl) < 1 then
        return nil
    else
        local newtbl = {}
        local tblsize = table.getn(tbl)
        local i = 2
        while (i <= tblsize) do
            table.insert(newtbl, i - 1, tbl[i])
            i = i + 1
        end
        return newtbl
    end
end

function map(tbl, func)
    local newtbl = {}
    for i, v in pairs(tbl) do
        newtbl[i] = func(v)
    end
    return newtbl
end

function filter(tbl, func)
    local newtbl = {}
    for i, v in pairs(tbl) do
        if func(v) then
            newtbl[i] = v
        end
    end
    return newtbl
end

function foldr(val, tbl, func)
    for i, v in pairs(tbl) do
        val = func(val, v)
    end
    return val
end

function reduce(tbl, func)
    return foldr(head(tbl), tail(tbl), func)
end

function fif(condition, if_true, if_false)
    if condition then
        return if_true
    else
        return if_false
    end
end

function sort(tbl, func)
    table.sort(tbl, func)
    return tbl
end
