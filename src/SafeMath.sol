pragma solidity ^0.4.21;

library SafeMath {
    
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 r = x + y;
        assert(r >= x);
        return r;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y <= x);
        return x - y;
    }
  
    function mul(uint256 x, uint256 y) internal pure returns (uint256) {
        if (x == 0 || y == 0) {
            return 0;
        }
        uint256 r = x * y;
        require(r / x == y);
        return r;
    }
    
    function div(uint256 x, uint256 y) internal pure returns (uint256) {
        return x / y;
    }
    
}
