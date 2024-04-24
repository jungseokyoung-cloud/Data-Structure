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

var openAddressing = OpenAddressingDictionary<String, String>()

openAddressing.insert("seoul", with: "jung")

openAddressing["jung"] = "busan"
openAddressing["jung"] // busan
openAddressing["kim"] // nil
openAddressing.count // 1

openAddressing["kim"] = "seoul"
openAddressing.count // 2

openAddressing["jung"] = nil
openAddressing["jung"] // nil
openAddressing.count // 1

openAddressing.find(for: "kim") // seoul

openAddressing.delete(for: "kim")
openAddressing.count // 0
