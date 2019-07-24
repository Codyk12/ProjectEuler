
function hits_89(dict::Dict, n::Int)
    x = n
    while x != 89 && x != 1
        if haskey(dict, n)
            x = dict[x]
        else
            x = square_digits(x)
        end
    end
    dict[n] = x
    x == 89 && (return 1)
    0
end

function square_digits(n::Int)
    sum([parse(Int, c)^2 for c in string(n)])
end

function Base.reverse(n::Int)
    parse(Int, reverse(string(n)))
end

function prob92(n::Int = 10000000)
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

    s = Set()

    cnt = 0
    for i = 1:n
        !(i in s) && push!(s, i)
        if i % 10 != 0 && !(reverse(i) in s)
            cnt += hits_89(dict, i)
        end
    end
    println("Numbers below ", n, " that will arrive at 89: ", cnt)
end

@time prob92()
