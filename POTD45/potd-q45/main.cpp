#include <iostream>
#include "Hash.h"

int main(){

	std::vector<int> doubleHashed;
	for (int i = 0; i <= 4; i++){
	    doubleHashed.push_back(-1);
		}
		doubleHashInput(doubleHashed, 20);
		doubleHashInput(doubleHashed, 30);

		std::cout << "Expected Result" << std::endl;
		std::cout << "[ "<< 20 << " ]" << std::endl;
		std::cout << "[ "<< -1 << " ]" << std::endl;
		std::cout << "[ "<< -1 << " ]" << std::endl;
		std::cout << "[ "<< 30 << " ]" << std::endl;
		std::cout << "[ "<< -1 << " ]\n" << std::endl;

		std::cout << "Your Result" << std::endl;
		for (int i = 0; i < doubleHashed.size(); i++){
			std::cout << "[ "<< doubleHashed[i] << " ]" << std::endl;
		}
}
