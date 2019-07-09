
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
