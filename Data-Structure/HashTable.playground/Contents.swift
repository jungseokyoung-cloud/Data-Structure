var chain = ChaingingDictionary<String, String>()

chain.insert("seoul", with: "jung")

chain["jung"] = "busan"
chain["jung"] // busan
chain["kim"] // nil
chain.count // 1

chain["kim"] = "seoul"
chain.count // 2

chain["jung"] = nil
chain["jung"] // nil
chain.count // 1

chain.find(for: "kim") // seoul

chain.delete(for: "kim")
chain.count // 0
