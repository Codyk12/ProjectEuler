function length_(x::BigInt)
    length(string(x))
end

function prob63()
    """
        Number of n-digit positive integers exist which are also an nth power
    """
    cnt = 0

    for i = 1:10, j= 1:100
        if length_(BigInt(i)^j) == j
            cnt += 1
        end
    end
    println("Number of numbers of the length of their power: ",cnt)
end

@time prob63()
