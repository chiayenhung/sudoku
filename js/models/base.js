(function() {
  define([], function() {
    var Base;
    return Base = (function() {
      Base.assignId = function(className, callback) {
        var data, id;
        data = JSON.parse(localStorage.getItem("autoIncrement"));
        if (!data) {
          data = {};
        }
        if (!(className in data)) {
          data[className] = 2;
          id = 1;
        } else {
          id = data[className];
          data[className]++;
        }
        localStorage.setItem("autoIncrement", JSON.stringify(data));
        return callback(id);
      };

      function Base() {
        this.attrs = {
          id: null,
          createTime: null,
          updateTime: null
        };
      }

      Base.prototype.get = function(key) {
        if (!key in this.attrs) {
          console.error(key, " not in attrs");
          return null;
        }
        return this.attrs[key];
      };

      Base.prototype.set = function(key, value) {
        if (!key in this.attrs) {
          console.error(key, " not in attrs");
          return this;
        }
        this.attrs[key] = value;
        return this;
      };

      Base.prototype.fetch = function(id, callback) {
        var data;
        if (!callback) {
          callback = function() {};
        }
        if (this.constructor.name in localStorage) {
          data = JSON.parse(localStorage.getItem(this.constructor.name));
          if (id in data) {
            this.attrs = data[id];
            return callback();
          } else {
            console.error(id, "not exists");
            return callback(true);
          }
        } else {
          console.error(this.constructor.name, "not exists");
          return callback(true);
        }
      };

      Base.prototype.save = function(callback) {
        var data, firstCreate,
          _this = this;
        data = null;
        if (!callback) {
          callback = function() {};
        }
        firstCreate = false;
        if (!(this.constructor.name in localStorage)) {
          data = {};
        } else {
          data = JSON.parse(localStorage.getItem(this.constructor.name));
        }
        if (!this.get("id")) {
          firstCreate = true;
          return Base.assignId(this.constructor.name, function(id) {
            _this.set("id", id);
            _this.attrs.createTime = new Date;
            _this.attrs.updateTime = new Date;
            data[_this.get("id")] = _this.attrs;
            localStorage.setItem(_this.constructor.name, JSON.stringify(data));
            return callback();
          });
        } else {
          data[this.get("id")] = this.attrs;
          data[this.get("id")].updateTime = new Date;
          localStorage.setItem(this.constructor.name, JSON.stringify(data));
          return callback(true);
        }
      };

      Base.prototype.remove = function(callback) {
        var data;
        if (!(this.constructor.name in localStorage)) {
          console.error(this.constructor.name, "is not created");
          return;
        }
        if (!callback) {
          callback = function() {};
        }
        data = JSON.parse(localStorage.getItem(this.constructor.name));
        if (!(this.get("id") in data)) {
          console.error("id", this.get("id"), this.constructor.name, "not in memory");
          return;
        }
        delete data[this.get("id")];
        localStorage.setItem(this.constructor.name, JSON.stringify(data));
        return callback();
      };

      return Base;

    })();
  });

}).call(this);
