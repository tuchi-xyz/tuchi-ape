//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "hardhat/console.sol";

contract BtkApe is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    using SafeMath for uint256;
    uint256 public constant maxSupply = 10000;
    uint256 public constant maxBatchSize = 100;
    uint256 public constant apePrice = 80000000000000000;

    constructor() ERC721("BTK BoredApeTestingClub", "BTKA") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
        // return "https://btk.upatra.com/meta/";
    }

    function reserveApes() public onlyOwner {
        uint i;

        for (i = 0; i < 30; i++) {
            uint supply = _tokenIdCounter.current();
            _safeMint(msg.sender, supply);
            _tokenIdCounter.increment();
        }
    }

    function mintApes(uint batchSize) public payable {
        require(_tokenIdCounter.current() + batchSize <= maxSupply, "reached max supply");
        require(batchSize <= maxBatchSize, "above max batch size");
        require(apePrice.mul(batchSize) <= msg.value, "Ether value sent is not correct");

        for(uint i = 1 ; i <= batchSize; i++) {
            _tokenIdCounter.increment();
            _safeMint(msg.sender, _tokenIdCounter.current());
        }
    }
}
