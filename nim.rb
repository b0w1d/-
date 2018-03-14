a = [3, 7, 5]

FST = %w(first second third)
Players = ["computer", "you"]
player = rand(2) & 1 # 0 is computer first

case player
when 0 then puts "Computer goes first."
else puts "You go first."
end

until a.all?(&:zero?)
  puts "\nThe piles are #{a.join(', ')}.\n"
  case player
  when 0
    puts "Computer's turn:"
    xor = a.reduce(:^)
    if xor.zero?
      sol = nil
      3.times do |i|
        next if a[i].zero?
        c = rand(a[i]) + 1
        a[i] -= c
        puts "Computer chose to deduct #{c} stone#{?s if c > 1} from the #{FST[i]} pile."
        break
      end
    else
      sol = nil
      3.times do |i|
        next if a[i].zero?
        (1..a[i]).each do |c|
          z = a.dup
          z[i] -= c
          sol = [i, c] if z.reduce(:^).zero?
        end
      end
      puts "Computer chose to deduct #{sol[1]} stone#{?s if sol[1] > 1} from the #{FST[sol[0]]} pile. He thinks you are going to lose."
      a[sol[0]] -= sol[1]
    end
  else
    puts "Your turn:"
    pile = nil
    puts "Which pile would you like to choose? It is 1, 2, 3 respectively, from the left."
    loop do
      pile = gets.strip.to_i
      case pile
      when 1..3
        pile -= 1
        if a[pile].zero?
          puts "This pile is empty. Choose another one."
          next
        end
        puts "You chose the #{FST[pile]} pile from the left."
        break
      else
        puts "Invalid option, please submit an integer in #{a.each_index.select { |i| a[i] > 0 } .map(&:next).join(', ')}."
      end
    end
    puts "How many stones would you like to take? Please submit an integer in #{(1..a[pile]).to_a}."
    loop do
      cnt = gets.strip.to_i
      case cnt
      when 1..a[pile]
        puts "You decided to deduct #{cnt} stone#{?s if cnt > 1} from the #{FST[pile]} pile."
        a[pile] -= cnt
        break
      else
        puts "Invalid option, please submit an integer in #{(1..a[pile]).to_a}."
      end
    end
  end
  player ^= 1
end

puts "\nThe piles are 0, 0, 0."
puts "#{Players[player].capitalize} lost this game!"
