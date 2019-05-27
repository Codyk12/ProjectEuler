
function find_divisors_sum(n)
    return sum([i for i in 1:n-1 if n % i == 0])
end

find_divisors_sum(10)

function prob21(n=10000)
    """
    Calculates sum of amicable numbers
    """
    sums = [find_divisors_sum(i) for i in 1:n]
    sums[1] = 1
    # println(sums[220])
    # println(sums[284])
    total = 0
    for (i,s) in enumerate(sums)
        # println(s)
        if (i != s && s < n && i == sums[s])
            println("Pair found ", i, " ", s)
            total += i
        end
    end
    total
end

print(prob21())
