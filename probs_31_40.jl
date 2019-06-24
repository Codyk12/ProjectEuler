
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
function ispandigital(num::String)
    s = ['1','2','3','4','5','6','7','8','9']
    for c in s
        if !(c in num)
            return false
        end
    end
    true
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
            if ispandigital(n, 9)
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

#--------------------------------------------------------------------------------------

function isPrime(n::Int)
    """
    Determines if n is a prime
    """
    if n == 1 return false end
    for i = 2:sqrt(n)
        d = n / i
        if d == round(d)
            return false
        end
    end
    true
end

function circular(n)
    n = string(n)
    circ = true
    for (i,c) in enumerate(n)
        if !isPrime(parse(Int, n[i:end]*n[1:i-1]))
            return false
        end
    end
    circ
end

function prob35(n=1000000)
    """
    Finds circular primes are there below n
    """
    cnt = 4
    for i = 11:n
        if i % 2 != 0 && circular(i)
            cnt += 1
        end
    end
    print("Number of circular primes under ", n, ": ", cnt)
end

@time prob35()

#--------------------------------------------------------------------------------------

function isPalendrome(n)
    """
    Checks if number is palendrome
    """
    pal = true
    for i = 1:Int(floor(length(n)/2))
        if n[i] != n[end-i+1]
            pal = false
            return pal
        end
    end
    pal
end

function prob36(n=1000000)
    """
    Finds sum of all numbers, less than n, which are palindromic in base 10 and base 2.
    """
    s = 0
    for i = 1:n
        if isPalendrome(string(i)) && isPalendrome(string(i, base=2))
            s += i
        end
    end
    println("Sum of Palindromic in base 10 and base 2 less than ", n, ": ", s)
end

@time prob36()


#--------------------------------------------------------------------------------------

function prob37()
    """
    Calculates the sum primes that are truncated primes both left and right
    """
    num = 0
    s = 0
    i = 23
    while num < 11
        si = string(i)
        if (i % 2 != 0 && isPrime(i) && left_trunc(si) && right_trunc(si))
            num += 1
            s += i
        end
        i += 1
    end
    print("Sum of truncated primes: ", s)
end

function left_trunc(n::String)
    for i = 1:length(n)
        if !(isPrime(parse(Int,n[i:end])))
            return false
        end
    end
    true
end

function right_trunc(n::String)
    for i = 1:length(n)-1
        if !(isPrime(parse(Int,n[1:end-i])))
            return false
        end
    end
    true
end

@time prob37()

#--------------------------------------------------------------------------------------

function prob38()
    """
    the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, … , n) where n > 1
    """
    for i in Iterators.reverse(9182:9876)
        n = string(i) * string(i*2)
        if ispandigital(n)
            println("Largest Pandigital concat number: ", n)
            break
        end
    end
end

prob38()

#--------------------------------------------------------------------------------------
function pathag_triples(n)
    count = 0
    for a = 1:round(n/2)
        for b = 1:round(n/2)
            c = sqrt(a^2 + b^2)
            if round(c) == c && (a + b + c == n)
                count += 1
            end
        end
    end
    count
end

function prob39(n=1000)
    """
    Number with most pathagorian triples
    """
    max = 0
    max_n = 0
    for i = 1:n
        m = pathag_triples(i)
        if m > max
            max = m
            max_n = i
        end
    end
    println("Number with most pathagorian triples: ", max_n)
end

@time prob39()

#--------------------------------------------------------------------------------------

function prob40(ds=[1,10,100,1000,10000,100000,1000000])
    """
    Gets the product of the dth digits of the Champernowne's constant
    """
    # Generate the range of the number of digits
    ones = (1,9)
    tens = (10,90*2+9)
    hundreds = ((90*2+9)+1, 900*3+(90*2+9))
    thousands = (900*3+(90*2+9)+1, 9000*4+(900*3+(90*2+9)))
    tenthou = (9000*4+(900*3+(90*2+9))+1, 90000*5+(9000*4+(900*3+(90*2+9))))
    hunthou = ((90000*5+(9000*4+(900*3+(90*2+9))))+1, 900000*6+(90000*5+(9000*4+(900*3+(90*2+9)))))
    ranges = [ones,tens,hundreds,thousands,tenthou,hunthou]
    prod = 1
    for d in ds
        for (i,r) in enumerate(ranges)
            if (d >= r[1] && d < r[2])
                n = Int(ceil(((d - (r[1]-1)) / i) + (10^(i-1))-1))
                index = (d - (r[1]-1)) % i
                if (index == 0)
                    prod *= 1
                else
                    prod *= parse(Int, string(n)[index])
                end
            end
        end

    end
    println("Product of the dth digits of Champernowne's constant: ", prod)
end

@time prob40()
