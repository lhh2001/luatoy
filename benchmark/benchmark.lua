local abcd_case_list = {
    { nil, nil, nil, nil },
    { {},  nil, nil, nil },
    { {},  {},  nil, nil },
    { {},  {},  {},  nil },
    { {},  {},  {},  {}  },
}

local a, b, c, d
local start_time
local iter_times = 5000000

local function safe_index(table, ...)
    for _, key in ipairs{...} do
        if not table then
        return nil
        end
        table = table[key]
    end
    return table
end

for _, abcd_case in ipairs(abcd_case_list) do
    a, b, c, d = table.unpack(abcd_case)
    print("value of a b c d:")
    print(a, b, c, d)

    -- if - else 简单粗暴 方法
    start_time = os.clock()
    for i = 1, iter_times do
        local var
        if a and a.b and a.b.c then
            var = a.b.c.d
        end
    end
    print("time cost 1-1 : ", os.clock() - start_time)

    -- if - else 使用缓存 方法
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

    -- or判空方法
    local empty_table = {}
    start_time = os.clock()
    for i = 1, iter_times do
        local var = (((a or empty_table).b or empty_table).c or empty_table).d
    end
    print("time cost 2 : ", os.clock() - start_time)

    -- 函数方法
    start_time = os.clock()
    for i = 1, iter_times do
        local var = safe_index(a, 'b', 'c', 'd')
    end
    print("time cost 3 : ", os.clock() - start_time)

    -- ?.方法
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a?.b?.c?.d
    end
    print("time cost 4 : ", os.clock() - start_time)

    -- 元表方法 {}
    debug.setmetatable(nil, { __index = {} })
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a.b.c.d
    end
    print("time cost 5-1 : ", os.clock() - start_time)
    debug.setmetatable(nil, nil)

    -- 元表方法 function
    debug.setmetatable(nil, { __index = function() end })
    start_time = os.clock()
    for i = 1, iter_times do
        local var = a.b.c.d
    end
    print("time cost 5-2 : ", os.clock() - start_time)
    debug.setmetatable(nil, nil)
end