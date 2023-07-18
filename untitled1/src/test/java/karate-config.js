function fn() {
    var config = read('classpath:env_data.json')
    var env = karate.env
    karate.log('The value of env is:', env);
    karate.configure('connectTimeout', 1000);
    karate.configure('readTimeout', 1000);
    return config[env];
}