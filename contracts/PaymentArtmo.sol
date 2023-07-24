// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract PaymentArtmo {
    struct Subscription {
        address owner;
        uint256 target;
        string title;
        string desc;
        address[] Users;
        string[] SubscriptionRole;
    }

    mapping(uint256 => Subscription) public subscriptions;

    uint256 public numberOfSubscriptions = 0;


    function createSubscription(address _owner, uint256 _target, string memory _title ,string memory _desc) public returns (uint256) {
        Subscription storage subscription = subscriptions[numberOfSubscriptions];

        subscription.owner = _owner;
        subscription.target = _target;
        subscription.title = _title;
        subscription.desc = _desc;
        numberOfSubscriptions++;
        return numberOfSubscriptions - 1;
    }
    function PlaceSubcription(uint256 _id) public payable {
        uint256 amount = msg.value;
        Subscription storage subscription = subscriptions[_id];
        (bool sent,) = payable(subscription.owner).call{value: amount}("");

        if(sent) {
            subscription.Users.push(msg.sender);
        }
    }
    function getSubscriptions() public view returns (Subscription[] memory) {
        Subscription[] memory allSubscription = new Subscription[](numberOfSubscriptions);

        for(uint i = 0; i < numberOfSubscriptions; i++) {
            Subscription storage item = subscriptions[i];

            allSubscription[i] = item;
        }

        return allSubscription;
    }

}