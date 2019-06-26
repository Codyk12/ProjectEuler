using BenchmarkTools

function isprime(n)
    """
    Determines if n is a prime
    """
    if n % 2 == 0
        return false
    else
        for i = 2:sqrt(n)
            d = n / i
            if d == round(d)
                return false
            end
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