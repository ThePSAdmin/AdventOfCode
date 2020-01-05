open System
open System.IO

let fuelRequired mass =
  mass / 3 - 2

let input =
  File.ReadAllLines(@"C:\Temp\aoc01.txt")
    |> Seq.map (fun s -> s |> int)

let fuel1 = 
    input 
     |> Seq.sumBy fuelRequired

let fuel2 mass =
    let rec calcFuel fuel =
      if fuel <= 0 then 0
      else fuel + calcFuel (fuelRequired fuel)
    calcFuel (fuelRequired mass)

let part2 = 
    input 
        |> Seq.sumBy fuel2
  