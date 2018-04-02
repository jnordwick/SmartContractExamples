pragma solidity ^0.4.21;

import "./SafeMath.sol";


contract PennyAuctionSimple {
    
    using SafeMath for uint256;

    uint256 public pxinc;
    uint256 public bidcost;
    uint256 public prize;
    bool public running;
    
    mapping(address => uint256) public overages;
    
    uint256 public px = 0;
    address public winner = address(0);
    address public owner = address(0);
    
    function PennyAuctionSimple(uint256 _pxinc,
                                uint256 _bidcost)
                            public payable {
        prize = msg.value;
        owner = msg.sender;
        pxinc = _pxinc;
        bidcost = _bidcost;
        winner = msg.sender;
        running = true;
    }
    
    function withdraw() public returns (uint256) {
        uint256 amt = overages[msg.sender];
        require(amt > 0);
        if(winner == msg.sender ) {
            assert(amt >= px);
            amt -= px;
        }
        if(amt > 0) {
            overages[msg.sender] -= amt;
            msg.sender.transfer(amt);
        }
        return amt;
    }
    
    function bid() public payable returns (uint256) {
        require(running);
        require(winner != msg.sender);
        uint256 nextpx = px + pxinc;
        uint256 total = nextpx + bidcost;
        uint256 available = overages[msg.sender].add(msg.value);
        require(available >= total);
        available = available.sub(total);
        if(available == 0) {
            delete overages[msg.sender];
        } else {
            overages[msg.sender] = available;
        }
        winner = msg.sender;
        px = nextpx;
        return px;
    }
    
    function resolve() public {
        require(running);
        require(msg.sender == owner);
        overages[winner] = overages[winner].add(prize);
        running = false;
    }
}
