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
