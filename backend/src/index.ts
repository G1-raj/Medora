interface User {
  id: number;
  name: string;
}

const user: User = {
  id: 1,
  name: "John"
};

function greet(user: User): string {
  return `Hello, ${user.name}!`;
}

console.log(greet(user));