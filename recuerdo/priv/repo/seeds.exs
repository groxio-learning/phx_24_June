now = NaiveDateTime.local_now
speeches = 
  Speech.list
  |> Enum.map(fn name -> 
    [
      name: name, 
      steps: 5, 
      text: Speech.passage(name), 
      inserted_at: now, 
      updated_at: now,
    ]
  end)
Recuerdo.Repo.insert_all( Recuerdo.Library.Passage, speeches)
