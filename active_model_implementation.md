# ActiveModel 3.0.0

## 基本的API

首先，是一个对象兼容ActiveModel的最基本的API（可以通过ActiveModel::Lint来检查），这些api包括：

* to_model
  返回一个实现了所有ActiveModel API的对象。

* persisted?
  是否已经持久化。生成url的根据（如form）

* to_key
  返回一个包括所有(primary) key attributes的Enumerable。当`persisted?`返回`false`时，返回nil。

* to_param
  返回一个适合在URL中使用的，代表该对象的key的字符串。当`persisted?`返回`false`时，返回nil。

* valid?
  可以通过`include ActiveModel::Validations`来获得（包括其它验证方法）

* model_name
  返回一个字符串，而且字符串要实现了相应的方法。最简单的方法是通过`include ActiveModel::Naming`来实现。

* errors
  返回一个对象实现了:[]和:full_messages的方法，而且这两个方法都必须返回一个Array。可以通过`include ActiveModel::Validations`来实现，也可以定义一个errors方法，返回ActiveModel::Errors的实例。
