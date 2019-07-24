
function hits_89(dict, n)
    while n != 89 && n != 1
        if n in dict
            n = dict[n]
        else
            n = square_digits
        end
    end
    n == 89 && (return 1)
    0
end

function square_digits(n)
    sum([parse(Int, c)^2 for c in string(n)])
end
function prob92()
    dict = Dict()
    dict[44] = 1
    dict[32] = 1
    dict[13] = 1

    dict[85] = 89
    dict[145] = 89
    dict[42] = 89
    dict[20] = 89
    dict[4] = 89
    dict[16] = 89
    dict[37] = 89
    dict[58] = 89

    ends_89 = 0
    for i = 1:10000000
        ends_89 += hits_89(dict, i)

    end

end
