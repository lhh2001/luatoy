local case_num <const> = 5
local abcd_case_list = {
    [1] = nil,
    [2] = { b = nil  },
    [3] = { b = {} },
    [4] = { b = { c = {} } },
    [5] = { b = { c = { d = {} } } },
}

local start_time
local empty_table = {}
local iter_times <const> = 5000000

local function safe_index(table, ...)
    for _, key in ipairs{...} do
        if not table then
        return nil
        end
        table = table[key]
    end
    return table
end

for i = 1, case_num do
    local a = abcd_case_list[i]
    print("value of a b c d:")
    print(a, a?.b, a?.b?.c, a?.b?.c?.d)

    -- if - else 暴力写法
    start_time = os.clock()
    for i = 1, iter_times do
        local var
        if a and a.b and a.b.c then
            var = a.b.c.d
        end
    end
    print("time cost 1-1 : ", os.clock() - start_time)

    -- if - else 使用缓存
    start_time = os.clock()
    for i = 1, iter_times do
        local var
        if a then
            local b = a.b
            if b then
                local c = b.c
                if c then
                    var = c.d
                end
            end
        end
    end
    print("time cost 1-2 : ", os.clock() - start_time)

    -- or判空 暴力写法
    start_time = os.clock()
    for i = 1, iter_times do
        local var = (((a or {}).b or {}).c or {}).d
    end
    print("time cost 2-1 : ", os.clock() - start_time)

    -- or判空 共享空表
    start_time = os.clock()
    for i = 1, iter_times do
        local var = (((a or empty_table).b or empty_table).c or empty_table).d
    end
    print("time cost 2-2 : ", os.clock() - start_time)

    -- 函数封装
    start_time = os.clock()
    for i = 1, iter_times do
        local var = safe_index(a, 'b', 'c', 'd')
    end
    print("time cost 3 : ", os.clock() - start_time)

    -- ?.运算符
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a?.b?.c?.d
    end
    print("time cost 4 : ", os.clock() - start_time)

    -- 元表  __index = {}
    debug.setmetatable(nil, { __index = {} })
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a.b.c.d
    end
    print("time cost 5-1 : ", os.clock() - start_time)
    debug.setmetatable(nil, nil)

    -- 元表  __index = function() end
    debug.setmetatable(nil, { __index = function() end })
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a.b.c.d
    end
    print("time cost 5-2 : ", os.clock() - start_time)
    debug.setmetatable(nil, nil)
end
