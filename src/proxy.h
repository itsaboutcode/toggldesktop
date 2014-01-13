// Copyright 2014 Tanel Lebedev

#ifndef SRC_PROXY_H_
#define SRC_PROXY_H_

#include <string>

#include "./types.h"

namespace kopsik {

  class Proxy {
   public:
    Proxy() :
      host(""),
      port(0),
      username(""),
      password("") {}

    bool IsConfigured() { return !host.empty() && port; }
    bool HasCredentials() {
      return !username.empty() && !password.empty(); }

    std::string host;
    Poco::UInt16 port;
    std::string username;
    std::string password;
  };

}  // namespace kopsik

#endif  // SRC_PROXY_H_