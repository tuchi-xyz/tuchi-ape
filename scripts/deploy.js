const main = async () => {
	const nftContractFactory = await hre.ethers.getContractFactory('BtkApe');
	const nftContract = await nftContractFactory.deploy();
	await nftContract.deployed();
	console.log("Contract deployed to:", nftContract.address);
  
	// Call the function.
	let txn = await nftContract.reserveApes()
	// Wait for it to be mined.
	await txn.wait()
	console.log("Reserve first 30 apes")
  };
  
  const runMain = async () => {
	try {
	  await main();
	  process.exit(0);
	} catch (error) {
	  console.log(error);
	  process.exit(1);
	}
  };
  
  runMain();