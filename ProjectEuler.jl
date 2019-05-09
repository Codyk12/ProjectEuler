function prob1(n)
    """
    Problem 1 for project Euler
    """
    nums = []
    for i in 3:n-1
        if (i % 5 == 0 || i % 3 == 0) && !in(i, nums)
            append!(nums, i)
        end
    end
    sum(nums)
end
prob1(1000)

# ------------------------------------------------------------------------------

function prob2()
    """
    Problem 2 for project Euler
    """
    fibs = [1, 2]
    sum = 2
    while fibs[2] < 4e6
        temp = fibs[2]
        fibs[2] = fibs[1] + fibs[2]
        fibs[1] = temp
        if (fibs[2] % 2 == 0)
            sum += fibs[2]
        end
    end
    sum
end

print(prob2())

# ------------------------------------------------------------------------------

function isPrime(n)
    prime = true
    for i = 2:sqrt(n)
        d = n / i
        if d == round(d)
            prime = false
            break
        end
    end
    prime
end

isPrime(9990)

function genPrimes(n)
    primes = [2,3]
    for i = 4:n
        if (isPrime(i))
            append!(primes, i)
        end
    end
    primes
end

genPrimes(20)


function prob3(n)
    """
    prime factors
    """
    primes = genPrimes(sqrt(n))
    d = 1
    # print(primes)

    # print(n, " ")
    results = []
    while !in(Int(d), primes)
        d = n / 2
        i = 1
        while d != round(d)
            # print("|", primes[i], "|")
            d = n / primes[i]
            i += 1
        end
        # print(primes[i-1],"ddd")
        append!(results, primes[i-1])
        # print(d, "d")
        n = d
    end
    append!(results, n)
    results
end

prob3(13195)
n = prob3(600851475143)
print(n)

# ------------------------------------------------------------------------------

function isPalendrome(n)
    str = string(n)
    l = length(str)
    if length(str) % 2 == 0
        pal = true
        for i = 1:Int(l/2)
            if str[i] != str[end-i+1]
                pal = false
                return pal
            end
        end
    else
        pal = true
        for i = 1:Int((l-1)/2)
            if str[i] != str[end-i+1]
                pal = false
                return pal
            end
        end
    end
    pal
end

isPalendrome(9889)


function prob4()
    max = 0
    for i in Iterators.reverse(100:999)
        for j in Iterators.reverse(100:999)
            n = i * j
            if n > max && isPalendrome(n)
                max = n
            end
        end
    end
    max
end

prob4()

# ------------------------------------------------------------------------------

function is_divis(n)
    s = 1:20
    devis = true
    for i in s
        if (n / i) != round(n / i)
            devis = false
        end
    end
    devis
end

function prob5()
    prod = 20
    while !is_divis(prod)
        prod += 1
    end
    prod
end

print(prob5())

# ------------------------------------------------------------------------------

function prob6()
    sum = 0
    sqr_sum = 0
    for i = 1:100
        sum += i
        sqr_sum += i^2
    end
    sum^2 - sqr_sum
end

print(prob6())

# ------------------------------------------------------------------------------

function prob7()
    n = 2
    p = 0
    primes = [2]
    while length(primes) < 10001
        n += 1
        if (isPrime(n))
            print(isPrime(n))
            print(n)
            print('\n')
            p += 1
            push!(primes, n)
        end
    end
    primes
end

print(prob7()[end])

# ------------------------------------------------------------------------------

function prob8()
    s="7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
        max = 0
    for i = 1:length(s)-12
        p = 1
        for j = i:i+12
            p *= parse(Int64, s[j])
            # print(parse(Int64, s[j]), " ")
            # print(p, "p")
            # print("\n")
        end
        if (p > max)
            max = p
        end
        # print(p)
        # break
    end
    max
end

print(prob8())

for i = 1:1+13
    print(i)
end

# ------------------------------------------------------------------------------

function is_pythagorean(n)
    is_p = false
    c = n
    tup = (0,0,c)
    for b = 1:n
        for a = 1:b
            if (c^2 == (a^2 + b^2))
                is_p = true
                tup = (a,b,c)
            end
        end
    end
    is_p, tup
end

print(is_pythagorean(100))

function prob9()
    for i in Iterators.reverse(1:1000)
        is_p, tup = is_pythagorean(i)
        if (is_p)
            print(tup, sum(tup), "\n")
            if sum(tup) == 1000
                print(tup)
                sum(tup)
                print("TRUE")
                print("----------------------------", prod(tup), "----------------------------")
                break
            end
        end
        prod(tup)
    end
end

prob9()
