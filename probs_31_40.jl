
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


#--------------------------------------------------------------------------------------

function check_digit_cancelling(n, d)
    r = Rational(n, d)
    n = string(n)
    d = string(d)
    if n[1] == d[1] && Rational(parse(Int, n[2]), parse(Int, d[2])) == r
        return true
    elseif n[1] == d[2] && Rational(parse(Int, n[2]), parse(Int, d[1])) == r
        return true
    elseif n[2] == d[1] && Rational(parse(Int, n[1]), parse(Int, d[2])) == r
        return true
    elseif n[2] == d[2] && Rational(parse(Int, n[1]), parse(Int, d[1])) == r
        return true
    end
    false
end


function prob33()
    denom = 1
    num = 1
    for d = 11:99, n = 10:d-1
        if (n % 10 != 0 && d % 10 != 0) && check_digit_cancelling(n, d)
            denom *= d
            num *= n
        end
    end
    print("Product of GDC of 4 special fractions: ", Rational(num,denom).den)
end


@time prob33()

#--------------------------------------------------------------------------------------


function prob34()
    """
    Finds the sum of all numbers which are equal to the sum of the factorial of their digits.
    """
    s = 0
    for i = 3:100000
        if i == sum([factorial(parse(Int,c)) for c in string(i)])
            s += i
        end
    end
    println("Sum of special sum of factorial digits numbers: ", s)
end

@time prob34()
