const express = require('express')
const app = express()
const port = 8080

const sampleData = [
  {
    title: 'lorem ipsum',
    description:
      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    img: 'https://fastly.picsum.photos/id/76/4912/3264.jpg?hmac=VkFcSa2Rbv0R0ndYnz_FAmw02ON1pPVjuF_iVKbiiV8'
  },
  {
    title: 'lorem ipsum',
    description:
      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    img: 'https://fastly.picsum.photos/id/84/1280/848.jpg?hmac=YFRYDI4UsfbeTzI8ZakNOR98wVU7a-9a2tGF542539s'
  },
  {
    title: 'lorem ipsum',
    description:
      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    img: 'https://fastly.picsum.photos/id/89/4608/2592.jpg?hmac=G9E4z5RMJgMUjgTzeR4CFlORjvogsGtqFQozIRqugBk'
  },
  {
    title: 'lorem ipsum',
    description:
      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    img: 'https://fastly.picsum.photos/id/120/4928/3264.jpg?hmac=i-8mkfKj_gRyQt9ZJVhbIBXbtIBNcsbI_gwNe_39vus'
  },
  {
    title: 'lorem ipsum',
    description:
      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
    img: 'https://fastly.picsum.photos/id/133/2742/1828.jpg?hmac=0X5o8bHUICkOIvZHtykCRL50Bjn1N8w1AvkenF7n93E'
  }
]

app.get('/', (req, res) => {
  console.log(sampleData)
  res.send(sampleData)
})

app.get('/user/:id', (req, res) => {
  console.log(req.params.id)
  console.log(sampleData[req.params.id] - 1)
  res.json(sampleData[parseInt(req.params.id) - 1])
})

app.listen(port, () => {
  console.log(`listening on port: ${port}`)
})
