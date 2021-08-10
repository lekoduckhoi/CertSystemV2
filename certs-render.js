
function add(n){
  for(var i=n-1;i>=0;i--){
  const course = document.createElement('div')
  course.classList.add('course')
  course.innerHTML =
  `<div class="course__image">
    <img id="image${i}" src="" alt="course image preview">
  </div>
  <div class="courseinfo">
  	<h2 id="name${i}" class="courseinfo__name"></h2>
	<p id="id${i}" class="courseinfo__id">Course Id: }</p>
  	<p id="date${i}" class="courseinfo__date">Date: </p>
  	<p id="issued${i}" class="courseinfo__issued">Issued by: Vietnam Institute for Advanced Study in Mathematics (VIASM)</p>
  	<p class="courseinfo__info">Course Information: <a id="info${i}" href="" target="_blank"></a></p>
</div>
  <div class="course__button">
    <button onclick="gotoProgram(${i})" class="gotocert">Find</button>
  </div>`
  $("#courses").append(course)
}}

document.querySelector('.backtocourse').addEventListener('click',function(){
  $('.certblock').css('left','50%')
})
const web3 = new Web3("https://bsc-dataseed.binance.org/")
const lay1Address = "0x65c7B6d15F3883a08B9009690B9206AAf2b021c4"
const lay2Address = "0x8D325a1b27FeaFEE9E35B8EDd52A0f89743C80da"
const lay1Abi = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "orgId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "orgName",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "orgContractAddress",
						"type": "address"
					}
				],
				"indexed": false,
				"internalType": "struct CertSystemLayer1.Organization",
				"name": "",
				"type": "tuple"
			}
		],
		"name": "Register",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "allOrganizations",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "orgId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "orgName",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "orgContractAddress",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "creator",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_orgAddress",
				"type": "address"
			}
		],
		"name": "finalized",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"name": "ipfsToProgramAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "isOrgAddress",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "maxProgramNumberOfOrg",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "maxTotalCertOfOrg",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "numberOfProgramHasPaid",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "orgCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_orgName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orglink",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orgPic",
				"type": "string"
			}
		],
		"name": "register",
		"outputs": [],
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_ipfs",
				"type": "string"
			},
			{
				"internalType": "bool",
				"name": "_isAddFunc",
				"type": "bool"
			}
		],
		"name": "setIpfsToActAddress",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_orgAddress",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_maxProgram",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_maxCert",
				"type": "uint256"
			}
		],
		"name": "setLimit",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
const lay2Abi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_orgId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_orgName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orglink",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orgPic",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "address",
						"name": "programContractAddress",
						"type": "address"
					}
				],
				"indexed": false,
				"internalType": "struct OrganizationContract.Program",
				"name": "",
				"type": "tuple"
			}
		],
		"name": "AddProgram",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_programName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_programPic",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_link",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_date",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_issuedBy",
				"type": "string"
			}
		],
		"name": "addNewProgram",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "allPrograms",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "name",
				"type": "string"
			},
			{
				"internalType": "address",
				"name": "programContractAddress",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "isProgramAddress",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "layer1Contract",
		"outputs": [
			{
				"internalType": "contract CertSystemLayer1",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bool",
				"name": "_isAddFunc",
				"type": "bool"
			}
		],
		"name": "modifyTotalCert",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "orgId",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "orgLink",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "orgName",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "orgPic",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "programCount",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "setNewOwner",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalCertCount",
		"outputs": [
			{
				"internalType": "int256",
				"name": "",
				"type": "int256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_orgName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orglink",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_orgPic",
				"type": "string"
			}
		],
		"name": "updateInfo",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
const lay3Abi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_programName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_programPic",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_link",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_date",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_issuedBy",
				"type": "string"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "certNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "issueTo",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "id",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "ipfsHash",
						"type": "string"
					}
				],
				"indexed": false,
				"internalType": "struct ProgramContract.Certificate",
				"name": "Newcert",
				"type": "tuple"
			}
		],
		"name": "AddCertificate",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "certNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "issueTo",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "id",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "ipfsHash",
						"type": "string"
					}
				],
				"indexed": false,
				"internalType": "struct ProgramContract.Certificate",
				"name": "Removecert",
				"type": "tuple"
			}
		],
		"name": "RemoveCertificate",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_issueTo",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_ipfsHash",
				"type": "string"
			}
		],
		"name": "addNewCerificate",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "allCertId",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"name": "certificateById",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "certNumber",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "issueTo",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "id",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "ipfsHash",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "date",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "issuedBy",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "layer2Contract",
		"outputs": [
			{
				"internalType": "contract OrganizationContract",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "link",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "programName",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "programPic",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_id",
				"type": "string"
			}
		],
		"name": "removeCertById",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "setNewOwner",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalAddedCert",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_programName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_programPic",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_link",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_date",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_issuedBy",
				"type": "string"
			}
		],
		"name": "updateInfo",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
const lay1con = new web3.eth.Contract(lay1Abi, lay1Address)
const lay2con = new web3.eth.Contract(lay2Abi, lay2Address)

lay2con.methods.programCount().call((err, prgcount) => {
	add(prgcount)
	for(let i = 0; i < prgcount; i++) {
		lay2con.methods.allPrograms(i).call((err,program) => {
			const lay3con = new web3.eth.Contract(lay3Abi, program.programContractAddress)
			$("#id"+String(i)).html("Course Id: " + i)
			lay3con.methods.date().call((err, _date) => {
				$("#date"+String(i)).html("Date: "+_date)
			})
			lay3con.methods.programName().call((err, _name) => {
				$("#name"+String(i)).html(_name)
			})
			lay3con.methods.link().call((err, _link) => {
				$("#info"+String(i)).html(_link)
				$("#info"+String(i)).attr("href", _link)
			})
			lay3con.methods.programPic().call((err, _pic) => {
				$("#image"+String(i)).attr("src", "https://gateway.pinata.cloud/ipfs/"+_pic)
			})
			lay3con.methods.issuedBy().call((err, _issued) => {
				$("#issued"+String(i)).html("Issued By: " + _issued)
			})
		})
	}
})
var findByAddress
function gotoProgram(n) {
  $('.certblock').css('left','-50%')
  lay2con.methods.allPrograms(n).call((err,program) => {
		findByAddress = program.programContractAddress
    	let lay3con = new web3.eth.Contract(lay3Abi, program.programContractAddress)
		$('.courseinfo__find__id').html("Course Id: " + n)
		lay3con.methods.date().call((err, _date) => {
			$('.courseinfo__find__date').html("Date: "+_date)
		})
		lay3con.methods.programName().call((err, _name) => {
			$('.courseinfo__find__name').html(_name)
		})
		lay3con.methods.link().call((err, _link) => {
			$('.courseinfo__find__info__a').html(_link)
			$('.courseinfo__find__info__a').attr('href', _link)
		})
		lay3con.methods.programPic().call((err, _pic) => {
			$('.course__find__image__src').attr("src", "https://gateway.pinata.cloud/ipfs/"+_pic)
		})
		lay3con.methods.issuedBy().call((err, _issuedBy) => {
  			$('.courseinfo__find__issued').html("Issued by: " + _issuedBy)
		})
	})
	setTimeout(function(){
		const backtv = document.querySelector('.backtocourse')
		backtv.scrollIntoView();
		const backtv1 = document.querySelector('body')
		backtv1.scrollIntoView();
	  },1500)
  
}

let submit = document.getElementById('submit')
let link_downloadable = document.getElementById('link__downloadable')
submit.addEventListener('click',()=>{
	cert_found.classList.add('hidden')
	let certId = $("#input").val()
	let lay3con = new web3.eth.Contract(lay3Abi, findByAddress)
  	lay3con.methods.certificateById(SHA1(certId)).call((err, res) => {
		if(res.issueTo == ""){
			alert("cert not found")
			//cert_found.classList.remove('hidden')
        	link_downloadable.innerHTML = "No link found"
        	$("#certImg").attr("src", "./image/defaultCert.jpg")
		} else {
			console.log("cert found")
			cert_found.classList.remove('hidden')
			$("#certImg").attr("src", "https://gateway.pinata.cloud/ipfs/"+res.ipfsHash)
			$("#abcd").html("CERTIFICATE DETAILS")
      		$("#idhash").html("Recipient ID hash: " + SHA1(certId))
			$("#issuedTo").html("Issued To: " + res.issueTo)
			$("#link__downloadable").attr("href","https://gateway.pinata.cloud/ipfs/"+res.ipfsHash)
			$("#link__downloadable").html("https://gateway.pinata.cloud/ipfs/"+res.ipfsHash)
			lay3con.methods.programName().call((err, _name) => {
				$("#course").html("Course: "+_name)
			})
			lay3con.methods.issuedBy().call((err, _issued) => {
				$("#issuedBy").html("Issued By: "+_issued)
			})
		}
	})
  
})

//verify

let verify_button = document.getElementById('verify__button')

    var file;
    var inpFile = document.getElementById("myFile");
    $("#verify__button").click(function() {
      $("#load").show()
      var cid
      file = inpFile.files[0]
      if (file == undefined) {
            alert("Please chose an image")
			$("#load").hide();
        } else {
            checked__right.classList.add('hidden')
            text_right.classList.add('hidden')
			checked__wrong.classList.add('hidden')
            text_wrong.classList.add('hidden')
			let data = new FormData();
            data.append('file', file);
            //pin to take cid
            axios.post(`https://api.pinata.cloud/pinning/pinFileToIPFS`, data, {
                    maxBodyLength: 'Infinity', //this is needed to prevent axios from erroring out with large files
                    headers: {
                        'Content-Type': `multipart/form-data; boundary=${data._boundary}`,
                        pinata_api_key: "50f2427237e2ba6f5487",
                        pinata_secret_api_key: "e7b44cb55ec2ac21e8b60e10b3ae1edfb2e2bc850e07d573df2e6b48b4bf95bb"
                    }
                })
            .then(function (response) {
              cid = response.data.IpfsHash;
              lay1con.methods.ipfsToProgramAddress(cid).call((err, res1) => {
                if(res1 != "0x0000000000000000000000000000000000000000"){   //ipfs found
				  $("#load").hide();
				  checked__right.classList.remove('hidden')
                  text_right.classList.remove('hidden')
                  $("#toProgram").click(() =>{
                    selected.style.left = selected.style.left === '50%' ? '' :'50%'
                    verify.classList.add('hidden')
                    cert.classList.remove('hidden')
                    checked__right.classList.add('hidden')
                    checked__wrong.classList.add('hidden')
                    text_right.classList.add('hidden')
                    text_wrong.classList.add('hidden')
                    $('.certblock').css('left','-50%')
					setTimeout(function(){
						const backtv = document.querySelector('.backtocourse')
						backtv.scrollIntoView();
						const backtv1 = document.querySelector('body')
						backtv1.scrollIntoView();
					},1500)
                    	let lay3con = new web3.eth.Contract(lay3Abi, res1)
                    	$('.courseinfo__find__id').html("Address: "+res1)
						lay3con.methods.date().call((err, _date) => {
							$('.courseinfo__find__date').html("Date: "+_date)
						})
						lay3con.methods.programName().call((err, _name) => {
							$('.courseinfo__find__name').html(_name)
						})
						lay3con.methods.link().call((err, _link) => {
							$('.courseinfo__find__info__a').html(_link)
							$('.courseinfo__find__info__a').attr("href", _link)
						})
						lay3con.methods.programPic().call((err, _pic) => {
							$('.course__find__image__src').attr("src", "https://gateway.pinata.cloud/ipfs/"+_pic)
						})
						lay3con.methods.issuedBy().call((err, _issuedBy) => {
				  		$('.courseinfo__find__issued').html("Issued by: " + _issuedBy)
						})
                  })
                }
                else { //ipfs not found
					        $("#load").hide();
				          checked__wrong.classList.remove('hidden')
                  text_wrong.classList.remove('hidden')
                  //unpin
                  const url = "https://api.pinata.cloud/pinning/unpin/"+ cid;
                  axios.delete(url, {
                  headers: {
                    pinata_api_key: "50f2427237e2ba6f5487",
                    pinata_secret_api_key: "e7b44cb55ec2ac21e8b60e10b3ae1edfb2e2bc850e07d573df2e6b48b4bf95bb"
                    }
                  })
                  .then(function (res) {
					          console.log("unpin successfully")
                  })
                  .catch(function (error) {
					          alert("cant unpin")
					          $("#load").hide();
                  })
                }
              })
            })
            .catch(function (error) {
				      alert("cant pin")
				      $("#load").hide();
            });
        }
    });   

	$(".FindCourseBtn").click(function(){
		var finId = Number($("#FindCourse").val())
		lay2con.methods.programCount().call((err, prgcount) => {
			if(!Number.isInteger(finId) || finId < 0){
				alert("There are currently "+String(prgcount)+" programs with ids of 0 to "+String(prgcount - 1)+"\nPlease type a correct id.")
			} else if(finId >= prgcount) {
				alert("There are currently "+String(prgcount)+" programs with ids of 0 to "+String(prgcount - 1)+"\nPlease type a correct id.")
			} else {
				$(".course").remove()
				const course = document.createElement('div')
				  course.classList.add('course')
				  course.innerHTML =
				  `<div class="course__image">
					<img id="image${finId}" src="" alt="course image preview">
				  </div>
				  <div class="courseinfo">
					<h2 id="name${finId}" class="courseinfo__name"></h2>
					  <p id="id${finId}" class="courseinfo__id">Course Id: }</p>
					  <p id="date${finId}" class="courseinfo__date">Date: </p>
					  <p id="issued${finId}" class="courseinfo__issued">Issued by: Vietnam Institute for Advanced Study in Mathematics (VIASM)</p>
					  <p class="courseinfo__info">Course Information: <a id="info${finId}" href=""></a></p>
				  </div>
				  <div class="course__button">
					<button onclick="gotoProgram(${finId})" class="gotocert">Find</button>
				  </div>`
				$("#courses").append(course)
			
				lay2con.methods.allPrograms(finId).call((err,program) => {
					const lay3con = new web3.eth.Contract(lay3Abi, program.programContractAddress)
					$("#id"+String(finId)).html("Id: " + finId)
					lay3con.methods.date().call((err, _date) => {
						$("#date"+String(finId)).html("Date: "+_date)
					})
					lay3con.methods.programName().call((err, _name) => {
						$("#name"+String(finId)).html(_name)
					})
					lay3con.methods.link().call((err, _link) => {
						$("#info"+String(finId)).html(_link)
						$("#info"+String(finId)).attr("href", _link)
					})
					lay3con.methods.programPic().call((err, _pic) => {
						$("#image"+String(finId)).attr("src", "https://gateway.pinata.cloud/ipfs/"+_pic)
					})
					lay3con.methods.issuedBy().call((err, _issued) => {
						$("#issued"+String(finId)).html("Issued By: " + _issued)
					})
				})
			}
		})
	})