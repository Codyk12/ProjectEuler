function prob71(m=1000000)
    fracts = Set{Rational{Int64}}()
    @time for d = 1:m
        for n = 1:d-1
            fract = n//d
            fract > 3//7 && break
            push!(fracts, fract)
        end
    end
    sort!(fracts)
    function three_sevenths(a)
        3//7 == a
    end
    println("Fraction to left of 3/7: ", fracts[findfirst(three_sevenths, fracts) - 1])
end

@time prob71()

#-------------------------------------------------------------------------------


function prob76(n=100)
    cnt = 1
    for i = 2:n
        allowable_nums = reverse!(collect(1:i))

        println(allowable_nums)

        num_i = 1
        sum = allowable_nums[1]
        num = sum

        while
            if n % num

        for num in allowable_nums[2:end]
            println(sum)
            if sum == n
                println("equals")
                cnt += 1
                sum = allowable_nums[1]
            elseif sum + num > n
                continue
            end
            sum += num
            println("added number:", num)
        end

    end
    println("Number of sums to make ", n, ": ", cnt)
end

prob76(5)
#-------------------------------------------------------------------------------

function prob79(file="p079_keylog.txt")
    codes = split(read(open(file),String), "\n")[1:end-1]
    nums = Set()

    #build alphabet
    for code in codes
        for c in code
            push!(nums, parse(Int,c))
        end
    end

    dict = Dict()
    for num in nums dict[num] = [] end

    for code in codes
        for i = 1:2
            for c in code[i+1:end]
                push!(dict[parse(Int,code[i])], parse(Int,c))
            end
        end
    end
    sort_order = [length(d[2]) for d in dict]
    order = sortperm(sort_order)
    keys = reverse([d[1] for d in dict][order])

    println("Keys in order of number characters that come after: ")
    for key in keys
        print(key)
    end

    reorder(keys, [1,2,4,3,5,6,7,8])
    reorder(keys, [1,3,2,4,5,6,7,8])
    reorder(keys, [1,3,4,2,5,6,7,8])
    reorder(keys, [1,4,2,3,5,6,7,8])
    reorder(keys, [1,4,3,2,5,6,7,8])

end


function reorder(keys, order)
    println("\nor")
    for key in keys[order]
        print(key)
    end
end

@time prob79()
