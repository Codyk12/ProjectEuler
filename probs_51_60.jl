
function prob51(args)
    body
end



#-------------------------------------------------------------------------------

function mult_same_digits(i::Int)
    Set(string(i)) == Set(string(2i)) == Set(string(3i)) == Set(string(4i)) == Set(string(5i)) == Set(string(6i))
end

function prob52()
    """
    finds smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

    """
    i = 9
    while true
        if i % 10 != 0 && mult_same_digits(i)
            println("Smallest same digits number: ", i)
            return
        end
        i += 1
    end
end


@time prob52()


#-------------------------------------------------------------------------------
using Combinatorics

function prob53()
    """
        Number of binomial 1 < n < 100 above 1 million
    """
    cnt = 0
    for n = 23:100
        for r = 1:n
            if binomial(BigInt(n), r) > 1000000
                cnt += 1
            end
        end
    end
    println("Over 1 million: ", cnt)
end

@time prob53()

#-------------------------------------------------------------------------------

function ispalendrome(n::Integer)
    """
    Checks if number is palendrome
    """
    n = string(n)
    for i = 1:Int(ceil(length(n)/2))
        if n[i] != n[end-i+1]
            return false
        end
    end
    true
end

ispalendrome(132)

function prob55()
    """
        Lychrel numbers that are below ten-thousand
    """
    cnt = 0
    for i = 10:10000
        num = BigInt(i)
        is_pal = false
        for j = 1:50
            num += parse(BigInt, reverse(string(num)))
            if ispalendrome(num)
                is_pal = true
                break
            end
        end
        cnt += !is_pal ? 1 : 0
    end
    println(cnt, " Lychrel numbers are below ten-thousand")
end

@time prob55()
