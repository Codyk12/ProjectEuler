
function find_divisors_sum(n)
    return sum([i for i in 1:n-1 if n % i == 0])
end

function prob21(n=10000)
    """
    Calculates sum of amicable numbers
    """
    sums = [find_divisors_sum(i) for i in 1:n]
    sums[1] = 1
    total = 0
    for (i,s) in enumerate(sums)
        if (i != s && s < n && i == sums[s])
            println("Pair found ", i, " ", s)
            total += i
        end
    end
    total
end

print(prob21())

 # -----------------------------------------------------------------------------

function prob22(file="p022_names.txt")
    lines = sort(split(replace(read(open(file), String), "\"" => ""), ","))
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
    total = 0
    for (i,word) in enumerate(lines)
        word_cnt = 0
        for c in word
            word_cnt += alpha[lowercase(c)]
        end
        total += (word_cnt * i)
    end
    total
end

print(prob22())


# -----------------------------------------------------------------------------

function prob23(n=28123)
    """
    Gets the sum of all the positive integers which
    cannot be written as the sum of two abundant numbers.
    """
    abundant = []
    for i = 1:n
        if find_divisors_sum(i) > i
            push!(abundant, i)
        end
    end
    sum_of_two = []
    for a in abundant
        for b in abundant
            push!(sum_of_two, a+b)
        end
    end
    sum_set = Set(sum_of_two)

    total = 0
    for i = 1:n
        if !(i in sum_set)
            total += i
        end
    end
    total
end


print(prob23())


# -----------------------------------------------------------------------------

using Combinatorics

function prob24(n=1000000)
    """
    Finds nth lexicographic permutation of the digits 1-9
    """
    nums = [0,1,2,3,4,5,6,7,8,9]
    l = length(nums)
    i = 0
    num = 0

    # Determine which starting number produces closest to n
    for j in nums
        num = j
        if (i+factorial(l-1) > n)
            break
        else
            i += factorial(l-1)
        end
    end

    # Removes the starting number for faster permutation calc
    deleteat!(nums, num+1)
    println(n, "th Permutation: ", num, collect(permutations(nums))[n-i]...)

end

prob24()

# -----------------------------------------------------------------------------

function prob25(n=1000)
    """
    Finds the fib number with n digits
    """
    index = 1
    fibs = [BigInt(0),BigInt(1)]
    while length(string(fibs[2])) < n
        new = BigInt(fibs[1]) + fibs[2]
        fibs[1] = fibs[2]
        fibs[2] = new
        index += 1
    end
    println("Index of the digit with ", n, " digits: ", index)
end

prob25()

# -----------------------------------------------------------------------------
using Decimals

function prob26(n=1000)
    """
    Finds the unit fraction with denominator less than n with the longest repeating decimal
    """
    sequenceLength = 0

    for i = 2:n

        if (sequenceLength >= i)
            print(sequenceLength)
            break
        end

        remainders = [i]
        val = 1
        position = 0
        # Long division:
        println("------------ ", i, " ---------")
        while remainders[val] == 0 && val != 0
            remainders[val] = position
            val *= 10
            val %= i
            position += 1
        end

        if (position - remainders[val] > sequenceLength)
            sequenceLength = position - remainders[val]
        end
    end
    print(sequenceLength)
end

prob26()
