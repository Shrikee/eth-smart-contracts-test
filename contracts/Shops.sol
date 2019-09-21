pragma solidity ^0.5.0;

contract Shops {
    uint public shopCount = 0;

    struct Shop {
        uint id;
        string name;
        string lat;
        string long;
        string createdTime;
    }

    event shopCreated (
        uint id,
        string name,
        string lat,
        string long,
        string createdTime
    );

    mapping(uint => Shop) public shopsMapping;

    function createShop(string memory _name, string memory _lat, string memory _long, string memory _createdTime) public {
        shopCount ++;
        shopsMapping[shopCount] = Shop(shopCount, _name, _lat, _long, _createdTime);
        emit shopCreated(shopCount, _name, _lat, _long, _createdTime);
    }
}