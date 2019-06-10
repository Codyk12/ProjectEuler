
function prob31(coins=[1,2,5,10,20,50,100,200], target=200)
    """
    Detects the number of ways to make the largest coin given any number of smaller coins.
    """
    ways = zeros(Int, target+1)
    ways[1] = 1

    for c in coins
        if c <= target
            for i = c:target
                ways[i+1] += ways[(i-c)+1]
            end
        end
    end
    println("Ways to calculate ", target, " given coins: ", coins, ": ", ways[end])
end

prob31()

#--------------------------------------------------------------------------------------
function isPandigital(num)
    s = ['1','2','3','4','5','6','7','8','9']
    if (length(num) != n)
        return false
    else
        flag = true
        for c in s
            if !(c in num)
                flag = false
                break
            end
        end
    end
    flag
end

function prob32(m0, m1, n0, n1)
    """
    sum of all products whose multiplicand/multiplier/product identity can be
    written as a 1 through 9 pandigital.
    """
    results = Set()
    for i = m0:m1
        for j = n0:n1
            num = i * j
            n = string(num) * string(i) * string(j)
            if isPandigital(n, 9)
                push!(results, num)
            end
        end
    end
    sum(results)
end

println("Pandigital for length 9: ", prob32(1,9,1234,9876) + prob32(12, 98, 123, 987))
