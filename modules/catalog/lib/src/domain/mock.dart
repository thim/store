import 'data.dart';

final mockList = [
  BaasboxData.fromJson({
    "_id": "1",
    "code": "1",
    "title": "Item 1",
    "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    "group": "Group1",
    "price": 15.7
  }),
  BaasboxData.fromJson({"_id": "2", "code": "2", "title": "Item 2", "detail": "Lorem ipsum dolor sit.", "group": "Group1", "price": 15.5}),
  BaasboxData.fromJson({
    "_id": "3",
    "code": "3",
    "title": "Item 3",
    "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    "group": "Group2",
    "price": 15.5
  }),
  BaasboxData.fromJson({
    "_id": "4",
    "code": "4",
    "title": "Item 4",
    "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    "group": "Group2",
    "price": 15.5
  }),
  BaasboxData.fromJson({
    "_id": "5",
    "code": "5",
    "title": "Item 5",
    "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    "group": "Group2",
    "price": 15.5
  }),
  BaasboxData.fromJson({
    "_id": "6",
    "code": "6",
    "title": "Item 6",
    "detail": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
    "group": "Group2",
    "price": 15.5
  }),
];

final listGroup = [
  BaasboxData.fromJson({
    "_id": "1",
    "name": "Group1",
  }),
  BaasboxData.fromJson({
    "_id": "2",
    "name": "Group2",
  }),
];
