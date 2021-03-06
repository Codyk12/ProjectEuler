using BenchmarkTools

function isprime(n::Int)
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


function ispandigital(num::String,n)
    s = [Char(i + '0') for i = 1:n]
    for c in s
        if !(c in num)
            return false
        end
    end
    true
end


function prob41()
    """
    Finds Largest pandigital prime
    """
    n = 0
    for i = 1000000:10000000
        s = string(i)
        if isprime(i) && ispandigital(s, length(s))
            n = i
        end
    end
    print("Largest Pandigital prime number: ", n)
end

@time prob41()

# ------------------------------------------------------------------------

function istriangleword(n)
    """
    Uses quadractic fomula to determine if the given nmber is a triangle number
    """
    num = (1 + sqrt(1+(8*n)))/ 2
    num2 = (1 - sqrt(1+(8*n)))/ 2
    return round(num) == num && round(num2) == num2
end


function prob42(file="p042_words.txt")
    """
    finds num of triangle words in file
    """
    words = sort(split(replace(read(open(file), String), "\"" => ""), ","))
    alpha = Dict('a' => 1,
    'b' => 2,
    'c' => 3,
    'd' => 4,
    'e' => 5,
    'f' => 6,
    'g' => 7,
    'h' => 8,
    'i' => 9,
    'j' => 10,
    'k' => 11,
    'l' => 12,
    'm' => 13,
    'n' => 14,
    'o' => 15,
    'p' => 16,
    'q' => 17,
    'r' => 18,
    's' => 19,
    't' => 20,
    'u' => 21,
    'v' => 22,
    'w' => 23,
    'x' => 24,
    'y' => 25,
    'z' => 26)
    cnt = 0
    for word in words
        if istriangleword(sum([alpha[lowercase(c)] for c in word]))
            cnt += 1
        end
    end
    println("There are ", cnt, " tirangle words in file ", file)

end

@time prob42()


# ------------------------------------------------------------------------
using Combinatorics

function substringprimediv(n::Array{Char})
    n = join(n)
    primes = [2, 3, 5, 7, 11, 13, 17]

    for i = 2:length(n)-2
        if !(parse(Int, n[i:i+2]) % primes[i-1] == 0)
            return false
        end
        i += 1
    end
    true
end

substringprimediv(1406357289)

function ispandigital(num::Vector{Char},n)
    s = [Char(i + '0') for i = 0:n]
    for c in s
        if !(c in num)
            return false
        end
    end
    true
end

function prob43(nums = ['0','1','2','3','4','5','6','7','8','9'])
    """
    Finds pandigital of digits nums with substrings divisible by primes
    """
    s = 0
    for n in permutations(nums)
        if ispandigital(n, 9) && substringprimediv(n)
            s += parse(Int, join(n))
        end
    end
    println("Sum of primesubstring property pandigital numbers: ", s)
end

@time prob43()

------------------------------------------------------------------------
function pentagonal(i)
    i*(3i - 1) / 2
end

function ispentagonal(i)
    pos = (1 + sqrt(1 + 24*i))/6
    round(pos) == pos ? true : false
end

function prob44(cap = 10000)
    """
    finds the pair of pentagonal numbers that are closest
    and sum and diff are also pentagonal
    """
    for i = 1:cap
        n = pentagonal(i)
        for j = 1:i-1
            m = pentagonal(j)
            s =  n + m
            d = n - m
            if ispentagonal(s) && ispentagonal(d)
                min_diff = d
                println("Difference: ", Int(min_diff))
                return
            end
        end
    end
end

@time prob44()


# ------------------------------------------------------------------------

function hexagonal_number(n)
    n*(2n-1)
end

function prob45()
    i = 143
    n = hexagonal_number(i)
    while true
        i += 1
        n = hexagonal_number(i)
        if ispentagonal(n)
            break
        end
    end
    println(Int(n), " ", i)
end

@time prob45()

# ------------------------------------------------------------------------

function gen_primes(m,n)
    [i for i = m:n if isprime(i)]
end

function prob46()
    """
    smallest odd composite that cannot be written as the sum of a prime and twice a square
    """
    primes = [2,3,5,7,11,13,17,19,23,27,31]

    i = 33

    flag = true

    while flag
        i += 2
        # println(i)
        if !(isprime(i))
            primes = vcat(primes, gen_primes(primes[end],i))
            found = false
            for j = Iterators.reverse(1:length(primes))
                num = sqrt((i-primes[j])/2)
                if num == round(num)
                    found = true
                    break
                end
            end
            found ? continue : break
        end
    end
    println("Smallest NOT goldbachs number: ",i)
end

@time prob46()


# ------------------------------------------------------------------------
function fuprimes(n, primes)
    rem = n
    uprimes = []
    for i = 1:length(primes)
        num = (rem / primes[i])
        if round(num) == num
            rem = num
            push!(uprimes, primes[i])
        end
    end
    length(uprimes) == 4
end

function prob47()
    """
    first 4 consecutive numbers to have 4 unique prime factors
    """
    cnt = 0
    i = 100000
    primes = gen_primes(1,50000)
    sat = false
    while !sat
        i += 1
        if fuprimes(i, primes)
            if cnt == 3
                break
            else
                cnt += 1
            end
        else
            cnt = 0
        end
    end
    println("First number in consecutive 4 unq primes: ", i-3)
end

@time prob47()

# ------------------------------------------------------------------------

function prob48()
    sum = 0
    for i = 1:1000
        sum += BigInt(i)^i
    end
    print("Last ten digits Sum of self powers: ", string(sum)[end-9:end])
end

@time prob48()

# ------------------------------------------------------------------------
using Combinatorics

function prob49()
    """
    finds increasing sequence of 3 numbers all primes and permutations of another
    the same distance apart
    """
    primes = gen_primes(1000,9999)
    for p in primes
        perm = collect(permutations([c for c in string(p)]))
        for prm in perm
            n1 = parse(Int, join(prm))
            if n1 in primes && n1 != p
                diff = (p - n1)
                n2 = (p + diff)
                if n2 != p && ([c for c in string(n2)] in perm) && n2 in primes
                    println("Concat sequence is: ", join(sort([n1, n2, p])))
                end
            end
        end
    end
end

@time prob49()

# ------------------------------------------------------------------------

function prob50(n=1000)
    """
    finds largest prime less than  n that is the sum of consecutive primes
    """
    max = 2
    p_num = 0
    primes = gen_primes(2,n)
    sums = [1]
    for (i,p) in enumerate(primes)
        push!(sums, sums[i] + primes[i])
    end

    for (i,p) in enumerate(primes)
        for j = Iterators.reverse(1:i-1)
            s = sums[i] - sums[j]
            diff = i - j
            if s > n
                break
            end
            if diff > max && s in primes
                max = diff
                p_num = s
            end
        end
    end
    println("Prime with Longest consecutive sum below ", n, ": ", p_num, ", with ", max, " primes")
end

@time prob50(1000000)
