// course example
let courses = [
  {
    coursename: "Course example",
    id: "123456789",
    issued: "leko",
    address: "abcxyzdefmno",
    info: "this is an example of a course",
    img: "./image/logo.jpg"
  },
  {
    coursename: "Course example 2",
    id: "987654321",
    issued: "leko",
    address: "xyzabcdefghi",
    info: "this is another example of a course",
    img: "./image/logo.jpg"
  },
  {
    coursename: "Course example 3",
    id: "123456789",
    issued: "leko",
    address: "abcxyzdefmno",
    info: "this is another example of a course",
    img: "./image/logo.jpg"
  },
  {
    coursename: "Course example 4",
    id: "987654321",
    issued: "leko",
    address: "khawijdsandkac",
    info: "this is another example of a course",
    img: "./image/logo.jpg"
  }
]

courses.forEach(el =>{
  const course = document.createElement('div')
  course.classList.add('course')
  course.innerHTML =
  `<div class="course__image">
    <img src="${el.img}" alt="course image preview">
  </div>
  <div class="courseinfo">
    <h2 class="courseinfo__name">${el.coursename}</h2>
    <p class="courseinfo__id">ID: ${el.id}</p>
    <p class="courseinfo__issued">Issued by: ${el.issued}</p>
    <p class="courseinfo__address">Address: ${el.address}</p>
    <p class="courseinfo__info">Info: ${el.info}</p>
  </div>
  <div class="course__button">
    <button class="gotocert">Find<i class="fa fa-long-arrow-right" aria-hidden="true"></i></button>
  </div>`
  $("#courses").append(course)
})
const certbtn = document.querySelectorAll('.gotocert')
certbtn.forEach(el =>{
  el.addEventListener('click',function(){
    $('.certblock').css('left','-50%')
    var i = Array.prototype.indexOf.call(certbtn,el)
    $('.course__find__image__src').attr('src',courses[i].img)
    $('.courseinfo__find__name').text(courses[i].coursename)
    $('.courseinfo__find__id').text('Id: ' + courses[i].id) 
    $('.courseinfo__find__issued').text('Issued by: ' + courses[i].issued)
    $('.courseinfo__find__address').text('Address: ' + courses[i].address)
    $('.courseinfo__find__info').text('Info: ' + courses[i].info)
  })
})
document.querySelector('.backtocourse').addEventListener('click',function(){
  $('.certblock').css('left','50%')
})
